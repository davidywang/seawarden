library(shiny)
library(leaflet)
library(leaflet.extras)
library(geojsonio)
library(leafpop)

shinyServer(function(input, output){
  
  src = "https://raw.githubusercontent.com/zdinh/seawarden/master/targets_2_simrdwn/"
  src_aoi = "https://raw.githubusercontent.com/zdinh/seawarden/master/0_search_areas/3_aoi/"
  src_img = "https://raw.githubusercontent.com/zdinh/seawarden/master/targets_2_simrdwn/1_SIMRDWN_final/annotated/"
  
  aoi = "_aoi.geojson"
  frm = "_simrdwn_farmsites_ext.geojson"
  pen = "_simrdwn_pens.geojson"
  pts = "_simrdwn_farm_pts_v2.geojson"
  
  f = "GRC"
  grc_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  grc_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  grc_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  grc_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  # f = "TUR"
  # tur_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # tur_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # tur_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # tur_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  # 
  # f = "HRV"
  # hrv_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # hrv_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # hrv_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # hrv_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  # 
  # f = "CYP"
  # cyp_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # cyp_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # cyp_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # cyp_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  # 
  # f = "ALB"
  # alb_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # alb_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # alb_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # alb_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  # 
  # f = "ITA"
  # ita_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # ita_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # ita_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # ita_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  # 
  # f = "ESP"
  # esp_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # esp_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # esp_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # esp_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  # 
  # f = "MLT"
  # mlt_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # mlt_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # mlt_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # mlt_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  # 
  # f = "FRA"
  # fra_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  # fra_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  # fra_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  # fra_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  base = "https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G"
  att = "Sea Warden 2020 | Google"

  #grc_img = "GRC/test_ssd_imagery_controlset_2020_04_15_06-47-03/"
  #img = "https://66.media.tumblr.com/a187444333b9b99693c4dede3078814c/5a1cf24832530c04-5d/s1280x1920/96250745741cbfe2bcd7023d7cd3bd2fab6960a8.jpg"
  #img = paste0(src, grc_img, "133_18_38_4666_26_1479_38_4576_26_1594_thresh%3D0.25..jpeg")
  #url = paste0("Detections | ", "<a href=", img, ' target="_blank"', ">View Image</a>")
  
  img = paste0(src_img, "image_(18, _ALB_, 23, 39.78452, 20.00564, 39.79353, 19.99396).jpeg")
  url = paste0("Detections | ", "<a href=", img, ' target="_blank"', ">View Image</a>")
  
  
  output$map <- renderLeaflet({
    leaflet() %>% 
    addTiles(urlTemplate = base, attribution = att) %>%
    setView(14, 40, zoom = 4) %>%
    setMaxBounds(-10, 50, 40, 30) %>%
    addFullscreenControl() %>%
    
      #data layers
      addPolygons(data=grc_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(grc_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=grc_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(grc_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=grc_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(grc_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      addCircleMarkers(data=grc_pts, radius = 1, color = '#3bb2d0', popup = paste0(url, popupImage(img, src = "remote", height=300, width=300))) #%>%
      
      # addPolygons(data=tur_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(tur_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=tur_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(tur_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=tur_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(tur_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=tur_pts, radius = 1, color = '#3bb2d0', popup = popupTable(tur_pts)) %>%
      # 
      # addPolygons(data=hrv_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(hrv_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=hrv_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(hrv_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=hrv_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(hrv_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=hrv_pts, radius = 1, color = '#3bb2d0', popup = popupTable(hrv_pts)) %>%
      # 
      # addPolygons(data=cyp_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(cyp_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=cyp_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(cyp_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=cyp_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(cyp_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=cyp_pts, radius = 1, color = '#3bb2d0', popup = popupTable(cyp_pts)) %>%
      # 
      # addPolygons(data=alb_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(alb_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=alb_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(alb_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=alb_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(alb_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=alb_pts, radius = 1, color = '#3bb2d0', popup = popupTable(alb_pts)) %>%
      # 
      # addPolygons(data=ita_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(ita_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=ita_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(ita_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=ita_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(ita_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=ita_pts, radius = 1, color = '#3bb2d0', popup = popupTable(ita_pts)) %>%
      # 
      # addPolygons(data=esp_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(esp_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=esp_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(esp_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=esp_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(esp_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=esp_pts, radius = 1, color = '#3bb2d0', popup = popupTable(esp_pts)) %>%
      # 
      # addPolygons(data=mlt_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(mlt_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=mlt_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(mlt_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=mlt_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(mlt_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=mlt_pts, radius = 1, color = '#3bb2d0', popup = popupTable(mlt_pts)) %>%
      # 
      # addPolygons(data=fra_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(fra_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=fra_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(fra_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addPolygons(data=fra_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(fra_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=fra_pts, radius = 1, color = '#3bb2d0', popup = popupTable(fra_pts))
    })
})
