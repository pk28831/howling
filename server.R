library(shiny)
require(ggplot2)
require(seewave)
require(tuneR)
require(dplyr)
#options(shiny.error=browser, error=recover)
# Define server logic for adding 2 signals
shinyServer(function(input, output) {
        # Generate a plot of the data.
        output$plot <- renderPlot({
                pi<-4*atan(1)
                t<-seq(0,5,1/5000)
                x1<-input$amp1*sin(2*pi*input$freq1*t)
                x2<-input$amp2*sin(2*pi*input$freq2*t+input$phase2/180.*pi)
                xt<-x1+x2
                ytot<-input$amp1+input$amp2
                df2<-data.frame(t,x1,x2,xt)
                names(df2)<-c("time","signal1","signal2","sum")
                p<-ggplot(df2, aes(x=time,y=signal1))
                p<-p+geom_line(line_type=1,mapping=(aes(color="signal1")))+
                        scale_x_continuous(limits = c(0.0, input$t_max))+
                        scale_y_continuous(limits=c(-ytot,ytot))+
                        ylab("amplitude")+
                geom_line(line_type=1,mapping=aes(x=time, y=signal2, color="signal2"), data=df2)+
                        geom_line(line_typem=1,mapping=aes(x=time, y=sum, color="sum"), data=df2)+
                        scale_colour_manual("sum of 2 time signals",
                                            values=c("signal1"="green","signal2"="blue","sum"="red"))
                p
        })
        
        
        # Calculate inputs  for a wav file and play the file
        output$plot2 <- renderPlot({
                "In RenderPlot2"
                pi<-4*atan(1)
                t2<-seq(0,5,1/44100)
                s1<-round(input$amp1*1600*sin(2*pi*input$freq1*t2))
                s2<-round(input$amp2*1600*sin(2*pi*input$freq2*t2+input$phase2/180*pi))
                s3<-s2+s1
                s4<-Wave(left=s3, samp.rate=44100,bit=16,pcm=TRUE)
#                s4<-Wave(left=s3, samp.rate=44100,bit=16)
                tdir<- "www/"
                tfile<- file.path(tdir,"audio.wav")
                writeWave(s4,filename=tfile)
                print("finished writing wav file, please conntinue")
#                s5<-readWave(filename=tfile)
#                tags$audio(src = "./howling.wav", type = "audio/wav")
#                play(s5, "./www/totem")         
        })
        output$text1 <- renderPlot(
                print("The output file is now written, please wait a few seconds, then continue. Please remember that you will probably #have to restart the app in order to listen to the signal you have made"))
        output$plot3 <- renderPlot({
                print("playing sound")
        })
#         #Play<-eventReactive(input$button, {
#         observeEvent(input$button,{
#                 cat("Writing wav file")
#         })
#         eventReactive(input$button,{
#                 
#                 "Inbutton"
#                 pi<-4*atan(1)
#                 s5<-synth(44100,5,input$freq1,input$amp1*2000,"sine",shape=NULL,p=0,
#                         am=c(0,0,0),fm=c(0,0,0),harmonics=1,plot=FALSE,output="Wave")
#                 s6<-synth(44100,5,input$freq2,input$amp2*2000,"sine",shape=NULL,
#                         p=input$phase/180*pi,am=c(0,0,0),fm=c(0,0,0),
#                         harmonics=1,plot=FALSE,output="Wave")
#                 s7<-s5+s6  
#                 str(s7)
#                 Wobj<-s7
#                 wav_dir<-"./www"
#                 wav_file<-file.path(wav_dir,"howling2.wav")
#                 writeWave(Wobj,filename=wav_file)
#                 play(s7)
#         })        
})
