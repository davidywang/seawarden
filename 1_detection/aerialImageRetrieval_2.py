import sys, io, os
from urllib import request
from PIL import Image
from tilesystem import TileSystem

#a0.ortho provides aerial images with labels
BASEURL = "http://a0.ortho.tiles.virtualearth.net/tiles/a{0}.jpeg?g=131"

#h0.ortho provides aerial images with labels
#http://h0.ortho.tiles.virtualearth.net/tiles/h{0}.jpeg?g=131

#IMAGEMAXSIZE = 8192 * 8192 * 8 # max width/height in pixels for the retrived image
IMAGEMAXSIZE = 1000 * 1000 * 8 # max width/height in pixels for the retrived image
TILESIZE = 256 # in Bing tile system, one tile image is in size 256 * 256 pixels

class AerialImageRetrieval(object):
    #def
    def __init__(self, n, id, lat1, lon1, lat2, lon2):
#     def __init__(self, cen_x, cen_y, lat1, lon1, lat2, lon2):
#         self.cen_x = cen_x
#         self.cen_y = cen_y
        self.n = n
        self.id = id
        self.lat1 = lat1
        self.lon1 = lon1
        self.lat2 = lat2
        self.lon2 = lon2
        self.tgtfolder = '/Users/Zack/0_bing_in/incoming'

        try:
            os.makedirs(self.tgtfolder)
        except FileExistsError:
            pass
        except OSError:
            raise
    #def    
    def download_image(self, quadkey):
        with request.urlopen(BASEURL.format(quadkey)) as file:
            return Image.open(file)

    #def
    def is_valid_image(self, image):
        """Check whether the downloaded image is valid, by comparing the downloaded image with a NULL image 
        returned by any unsuccessfully retrieval Bing tile system will return the same NULL image if the query 
        quadkey is not existed in the Bing map database.
        
        Arguments:
            image {[Image]} -- [a Image type image to be valided]
        
        Returns:
            [boolean] -- [whether the image is valid]
        """

        if not os.path.exists('null.png'):
            nullimg = self.download_image('11111111111111111111')   
            # an invalid quadkey which will download a null jpeg from Bing tile system
            nullimg.save('./null.png')
        return not (image == Image.open('./null.png'))
    
    #def
    def max_resolution_imagery_retrieval(self):
        #for levl in range(TileSystem.MAXLEVEL, 0, -1):
        for levl in range(19, 0, -1):
            pixelX1, pixelY1 = TileSystem.latlong_to_pixelXY(self.lat1, self.lon1, levl)
            pixelX2, pixelY2 = TileSystem.latlong_to_pixelXY(self.lat2, self.lon2, levl)

            pixelX1, pixelX2 = min(pixelX1, pixelX2), max(pixelX1, pixelX2)
            pixelY1, pixelY2 = min(pixelY1, pixelY2), max(pixelY1, pixelY2)
            
            #Bounding box's two coordinates coincide at the same pixel, which is invalid for an aerial image.
            #Raise error and directly return without retriving any valid image.
            if abs(pixelX1 - pixelX2) <= 1 or abs(pixelY1 - pixelY2) <= 1:
                print("*Cannot find a valid aerial imagery for the given bounding box!")
                return

            if abs(pixelX1 - pixelX2) * abs(pixelY1 - pixelY2) > IMAGEMAXSIZE:
                print("*Current level {} results an image exceeding the maximum image size (8192 * 8192), will SKIP".format(levl))
                continue
            
            tileX1, tileY1 = TileSystem.pixelXY_to_tileXY(pixelX1, pixelY1)
            tileX2, tileY2 = TileSystem.pixelXY_to_tileXY(pixelX2, pixelY2)

            # Stitch the tile images together
            result = Image.new('RGB', ((tileX2 - tileX1 + 1) * TILESIZE, (tileY2 - tileY1 + 1) * TILESIZE))
            retrieve_sucess = False
            for tileY in range(tileY1, tileY2 + 1):
                retrieve_sucess, horizontal_image = self.horizontal_retrieval_and_stitch_image(
                    tileX1, tileX2, tileY, levl)
                if not retrieve_sucess:
                    break
                result.paste(horizontal_image, (0, (tileY - tileY1) * TILESIZE))
            if not retrieve_sucess:
                continue
            #crop the image based on the given bounding box
            leftup_cornerX, leftup_cornerY = TileSystem.tileXY_to_pixelXY(tileX1, tileY1)
            retrieve_image = result.crop((pixelX1 - leftup_cornerX, pixelY1 - leftup_cornerY, \
                                        pixelX2 - leftup_cornerX, pixelY2 - leftup_cornerY))
#             print("*Finish the aerial image retrieval, store the image image_{}.jpeg in folder {1}".format(levl, self.tgtfolder))
            #name = levl,self.cen_y,self.cen_x,self.lat1,self.lon1,self.lat2,self.lon2
            name = levl,self.n,self.id,self.lat1,self.lon1,self.lat2,self.lon2
            filename = os.path.join(self.tgtfolder, 'image_{}.jpeg'.format(name))
            retrieve_image.save(filename)
            return True
        return False    
      
    #def
    def horizontal_retrieval_and_stitch_image(self, tileX_start, tileX_end, tileY, level):
        imagelist = []
        for tileX in range(tileX_start, tileX_end + 1):
            quadkey = TileSystem.tileXY_to_quadkey(tileX, tileY, level)
            image = self.download_image(quadkey)
            if self.is_valid_image(image):
                imagelist.append(image)
            else:
                #print(quadkey)
                print("*Cannot find tile image at level {0} for tile coordinate ({1}, {2})".format(level, tileX, tileY))
                return False, None
        result = Image.new('RGB', (len(imagelist) * TILESIZE, TILESIZE))
        for i, image in enumerate(imagelist):
            result.paste(image, (i * TILESIZE, 0))
        return True, result

##############################################################################################################

def main():
    """The main entrance. Decode the upper left and lower right coordinates, 
        and retrieve the aerial image withing that bounding box"""

    #decode the bounding box coordinates
    try:
        args = sys.argv[1:]
    except IndexError:
        sys.exit('*Diagonal (Latitude, Longitude) coordinates of the bounding box must be input.')
    if len(args) != 4:
        sys.exit('*Please input Latitude, Longitude coordinates for both upper-left and lower-right corners.')
    
    try:
        lat1, lon1, lat2, lon2 = float(args[0]), float(args[1]), float(args[2]), float(args[3])
    except ValueError:
        sys.exit('*Latitude and longitude must be float type')
        
##############################################################################################################    
    # Retrieve the aerial image
#     imgretrieval = AerialImageRetrieval(lat1, lon1, lat2, lon2)
#     if imgretrieval.max_resolution_imagery_retrieval():
#         print("*Successfully retrieved the image with maximum resolution.")
#     else:
#         print("*Cannot retrieve desired image.")

##############################################################################################################

if __name__ == '__main__':
    main()