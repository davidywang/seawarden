library(shiny)
library(leaflet)
library(geojsonio)

shinyServer(function(input, output){

  src_aoi = "https://raw.githubusercontent.com/zdinh/seawarden/master/0_search_areas/3_aoi/"
  src = "https://raw.githubusercontent.com/zdinh/seawarden/master/targets_2_simrdwn/"
  
  aoi = "_aoi.geojson"
  frm = "_simrdwn_farmsites_ext.geojson"
  pen = "_simrdwn_pens.geojson"
  pts = "_simrdwn_farm_pts.geojson"
  
  f = "GRC"
  grc_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  grc_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  grc_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  grc_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "TUR"
  tur_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  tur_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  tur_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  tur_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "HRV"
  hrv_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  hrv_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  hrv_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  hrv_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "CYP"
  cyp_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  cyp_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  cyp_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  cyp_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "ALB"
  alb_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  alb_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  alb_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  alb_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "ITA"
  ita_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  ita_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  ita_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  ita_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "ESP"
  esp_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  esp_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  esp_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  esp_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "MLT"
  mlt_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  mlt_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  mlt_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  mlt_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  f = "FRA"
  fra_aoi <- geojson_read(paste0(src_aoi, f, aoi),  what = "sp")
  fra_frm <- geojson_read(paste0(src, f, "/", f, frm), what = "sp")
  fra_pen <- geojson_read(paste0(src, f, "/", f, pen), what = "sp")
  fra_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")
  
  base = "https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G"
  att = "Sea Warden | Google"

  output$map <- renderLeaflet({
    leaflet() %>% 
    addTiles(urlTemplate = base, attribution = att) %>%
    setView(14, 40, zoom = 4) %>%
    setMaxBounds(-10, 50, 40, 30) %>%
    
      #data layers
      addPolygons(data=grc_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(grc_aoi)) %>%
      addPolygons(data=grc_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(grc_frm)) %>%
      addPolygons(data=grc_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(grc_pen)) %>%
      addCircleMarkers(data=grc_pts, radius = 1, color = '#3bb2d0', popup = popupTable(grc_pts)) %>%
      
      addPolygons(data=tur_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(tur_aoi)) %>%
      addPolygons(data=tur_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(tur_frm)) %>%
      addPolygons(data=tur_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(tur_pen)) %>%
      addCircleMarkers(data=tur_pts, radius = 1, color = '#3bb2d0', popup = popupTable(tur_pts)) %>%
      
      addPolygons(data=hrv_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(hrv_aoi)) %>%
      addPolygons(data=hrv_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(hrv_frm)) %>%
      addPolygons(data=hrv_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(hrv_pen)) %>%
      addCircleMarkers(data=hrv_pts, radius = 1, color = '#3bb2d0', popup = popupTable(hrv_pts)) %>%
      
      addPolygons(data=cyp_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(cyp_aoi)) %>%
      addPolygons(data=cyp_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(cyp_frm)) %>%
      addPolygons(data=cyp_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(cyp_pen)) %>%
      addCircleMarkers(data=cyp_pts, radius = 1, color = '#3bb2d0', popup = popupTable(cyp_pts)) %>%
      
      addPolygons(data=alb_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(alb_aoi)) %>%
      addPolygons(data=alb_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(alb_frm)) %>%
      addPolygons(data=alb_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(alb_pen)) %>%
      addCircleMarkers(data=alb_pts, radius = 1, color = '#3bb2d0', popup = popupTable(alb_pts)) %>%
      
      addPolygons(data=ita_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(ita_aoi)) %>%
      addPolygons(data=ita_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(ita_frm)) %>%
      addPolygons(data=ita_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(ita_pen)) %>%
      addCircleMarkers(data=ita_pts, radius = 1, color = '#3bb2d0', popup = popupTable(ita_pts)) %>%
      
      addPolygons(data=esp_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(esp_aoi)) %>%
      addPolygons(data=esp_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(esp_frm)) %>%
      addPolygons(data=esp_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(esp_pen)) %>%
      addCircleMarkers(data=esp_pts, radius = 1, color = '#3bb2d0', popup = popupTable(esp_pts)) %>%
      
      addPolygons(data=mlt_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(mlt_aoi)) %>%
      addPolygons(data=mlt_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(mlt_frm)) %>%
      addPolygons(data=mlt_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(mlt_pen)) %>%
      addCircleMarkers(data=mlt_pts, radius = 1, color = '#3bb2d0', popup = popupTable(mlt_pts)) %>%
      
      addPolygons(data=fra_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(fra_aoi)) %>%
      addPolygons(data=fra_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(fra_frm)) %>%
      addPolygons(data=fra_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(fra_pen)) %>%
      addCircleMarkers(data=fra_pts, radius = 1, color = '#3bb2d0', popup = popupTable(fra_pts))
    })
})
