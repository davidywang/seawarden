#function to extract and format x/y points
import pandas as pd

def coord(input_list):
    pt1, pt2, pt3, pt4, pt5 = map(list, zip(*input_list))
    x1, y1, = map(list, zip(*pt1))
    x2, y2, = map(list, zip(*pt2))
    x3, y3, = map(list, zip(*pt3))
    x4, y4, = map(list, zip(*pt4))
    x5, y5, = map(list, zip(*pt5))

    x1=str(x1).strip("[]")
    x2=str(x2).strip("[]")
    x3=str(x3).strip("[]")
    x4=str(x4).strip("[]")
    x5=str(x5).strip("[]")

    y1=str(y1).strip("[]")
    y2=str(y2).strip("[]")
    y3=str(y3).strip("[]")
    y4=str(y4).strip("[]")
    y5=str(y5).strip("[]")

    coord_group = {'x': [x1, x2, x3, x4, x5], 'y': [y1, y2, y3, y4, y5]}
    coord_group_df = pd.DataFrame(data=coord_group)
    return coord_group_df