library(shiny)
library(leaflet)
library(leaflet.extras)
library(geojsonio)
library(leafpop)

shinyServer(function(input, output){
  
  src = "https://raw.githubusercontent.com/zdinh/seawarden/master/targets_2_simrdwn/3_new/"
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
  # esp_pts <- geojson_read(paste0(src, f, "/", f, pts), what = "sp")

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
  att = "Sea Warden 2020 | Google"

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
      #addCircleMarkers(data=grc_pts, radius = 1, color = '#3bb2d0', popup = paste0('<a href="', src_img, grc_pts$filename,'">View Image</a>')) %>%
      addCircleMarkers(data=grc_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0(' Farm Site: ', grc_pts$farm.ID, ' <a href="', src_img, grc_pts$filename,'" target="_blank"','">View Image</a>'), 
        popupImage(paste0(src_img, grc_pts$filename), src = "remote", height=300, width=300))) %>%
    
      addPolygons(data=tur_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(tur_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=tur_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(tur_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=tur_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(tur_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=tur_pts, radius = 1, color = '#3bb2d0', popup = popupTable(tur_pts)) %>%
      addCircleMarkers(data=tur_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0('Farm Site: ', tur_pts$farm.ID, ' <a href="', src_img, tur_pts$filename,'" target="_blank"','">View Image</a>'),
        popupImage(paste0(src_img, tur_pts$filename), src = "remote", height=300, width=300))) %>%

      addPolygons(data=hrv_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(hrv_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=hrv_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(hrv_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=hrv_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(hrv_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=hrv_pts, radius = 1, color = '#3bb2d0', popup = popupTable(hrv_pts)) %>%
      addCircleMarkers(data=hrv_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0('Farm Site: ', hrv_pts$farm.ID, ' <a href="', src_img, hrv_pts$filename,'" target="_blank"','">View Image</a>'),
        popupImage(paste0(src_img, hrv_pts$filename), src = "remote", height=300, width=300))) %>%

      addPolygons(data=cyp_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(cyp_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=cyp_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(cyp_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=cyp_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(cyp_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=cyp_pts, radius = 1, color = '#3bb2d0', popup = popupTable(cyp_pts)) %>%
      addCircleMarkers(data=cyp_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0('Farm Site: ', cyp_pts$farm.ID, ' <a href="', src_img, cyp_pts$filename,'" target="_blank"','">View Image</a>'),
        popupImage(paste0(src_img, cyp_pts$filename), src = "remote", height=300, width=300))) %>%

      addPolygons(data=alb_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(alb_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=alb_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(alb_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=alb_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(alb_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=alb_pts, radius = 1, color = '#3bb2d0', popup = popupTable(alb_pts)) %>%
      addCircleMarkers(data=alb_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0('Farm Site: ', alb_pts$farm.ID, ' <a href="', src_img, alb_pts$filename,'" target="_blank"','">View Image</a>'),
        popupImage(paste0(src_img, alb_pts$filename), src = "remote", height=300, width=300))) %>%

      addPolygons(data=ita_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(ita_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=ita_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(ita_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=ita_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(ita_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=ita_pts, radius = 1, color = '#3bb2d0', popup = popupTable(ita_pts)) %>%
      addCircleMarkers(data=ita_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0('Farm Site: ', ita_pts$farm.ID, ' <a href="', src_img, ita_pts$filename,'" target="_blank"','">View Image</a>'),
        popupImage(paste0(src_img, ita_pts$filename), src = "remote", height=300, width=300))) %>%

      addPolygons(data=esp_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(esp_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=esp_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(esp_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=esp_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(esp_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=esp_pts, radius = 1, color = '#3bb2d0', popup = popupTable(esp_pts)) %>%
      
      # addCircleMarkers(data=esp_pts, radius = 1, color = '#3bb2d0', popup = paste0(
      #   paste0('Farm Site: ', esp_pts$farm.ID, ' <a href="', src_img, esp_pts$filename,'" target="_blank"','">View Image</a>'),
      #   popupImage(paste0(src_img, esp_pts$filename), src = "remote", height=300, width=300))) %>%

      addPolygons(data=mlt_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(mlt_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=mlt_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(mlt_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=mlt_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(mlt_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=mlt_pts, radius = 1, color = '#3bb2d0', popup = popupTable(mlt_pts)) %>%
      addCircleMarkers(data=mlt_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0('Farm Site: ', mlt_pts$farm.ID, ' <a href="', src_img, mlt_pts$filename,'" target="_blank"','">View Image</a>'),
        popupImage(paste0(src_img, mlt_pts$filename), src = "remote", height=300, width=300))) %>%

      addPolygons(data=fra_aoi, color = 'white', weight = 1, fillOpacity = 0, popup = popupTable(fra_aoi, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=fra_frm, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(fra_frm, feature.id = FALSE, row.numbers = FALSE)) %>%
      addPolygons(data=fra_pen, color = '#3bb2d0', weight = 2, fillOpacity = 0, popup = popupTable(fra_pen, feature.id = FALSE, row.numbers = FALSE)) %>%
      # addCircleMarkers(data=fra_pts, radius = 1, color = '#3bb2d0', popup = popupTable(fra_pts))
      addCircleMarkers(data=fra_pts, radius = 1, color = '#3bb2d0', popup = paste0(
        paste0('Farm Site: ', fra_pts$farm.ID, ' <a href="', src_img, fra_pts$filename,'" target="_blank"','">View Image</a>'),
        popupImage(paste0(src_img, fra_pts$filename), src = "remote", height=300, width=300)))
    })
})
