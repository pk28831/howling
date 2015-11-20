library(shiny)
require(ggplot2)
# Define UI for random distribution application 
shinyUI(fluidPage(
        # Application title
        titlePanel("Summing 2 time signals"),
        # Sidebar with controls to select the frequencies, amplitudes and phase
        # angle of the second signal
        sidebarLayout(
                sidebarPanel(
                        # Slider for frequency 1peter,knapen@dsm.com
                        sliderInput("freq1", "frequency 1",
                                    min=100, max=250, value=100, step=1.0),
                        # Slider for frequency 2
                        sliderInput("freq2", "frequency 2",
                                    min = 100, max =250, value = 100, step=1.0),
                        # Slider for amplitude1
                        sliderInput("amp1", "amplitude 1",
                                    min = 0, max = 10, value = 1, step= 0.1),
                        # Slider for amplitude2
                        sliderInput("amp2", "amplitude 2",
                                    min = 0, max = 10, value = 1, step= 0.01),
                        # Slider for phase angle
                        sliderInput("phase2", "difference in phase angle ",
                                    min = 0, max = 180, value = 0, step= 1.0),
                        
                        br(),
                        
                        sliderInput("t_max", 
                                    "Maximum scale x of the plot:", 
                                    value =5,
                                    min = 0, 
                                    max = 5, 
                                    step=.01)
                        ),
                # Show a tabset that includes a plot, summary, and table view
                # of the generated distribution
                mainPanel(
                        tabsetPanel(type = "tabs",
                                    tabPanel("Read me first",
                                             p("This is an exercize in adding 2 sinusoidal time signals. With the sliderbars you can give as input the frequencies and amplitudes. There is also a slider bar for the phase angle of the second signal. If you apply 90 degrees phase angle, the second signal transforms in a cosine function."),
                                             p("With the sliderbar for the maximum scale x, the scale of the plots are scaled between 0 and the maximum. As the signals are between 100 and 250 Hz, and 5 seconds long, one can zoom in on the signal by taking the maximum as 0.1 or 0.2"),
                                             br(),
                                             p("Some situations are nice to examine:"),
                                             p("if you take the amplitudes equal and the frequencies equal than the sum will be dependent on the phase angle of signal 2: if the phase angle is 0, the amplitude will be doubled, if the phase angle is 180, the signals will be cancelled out."),
                                             p("if you take the amplitudes equal, the phase angle 0, but a differences of 1 Hz between the signals, you will see a phenonemum called beating or howling: the amplitude of the total signal will vary between 0 and the sum of the two, with a frequency equal to the difference in frequency: 1 Hz in this case. This can be seen best by applying 5 seconds as maximum x-scale "),
                                             br(),
                                             p("On the plot page you can see the graphical output instantaneously"),
                                             br(),
                                             p(" On the Wav_output page, you can listen to the signal you have first looked to on the plot page."),
                                             p("For listening the amplitude should be between 1 and 10.", span("If you are using a headphone, please start with low amplitude, to prevent hearing damage. For one or another reason the sound of the latest file ran, is now also heard in the 'Read me first' tab. when the application is started. Please save a signal with amplitudes=1 at the end of your session and play it.",style="color:red")," Probably you will notice the filtering of your ear: signals at 100 Hz are attenuated more than those at 250 Hz (approximately by 11dB(A))."),
                                             p("There is however 3 buts: up to now I have got it running only with Chrome as browser, despite autoplay=NA, the playing starts immediately when the tab is opened and lastly the signal can only be detached by restarting the app: the file is written, but the uid.R has to be reread  in order to listen to the new signal"),
                                             p("To avoid this I have included 3 examples"),
                                             p("The source can be found on https://github.com/pk28831/howling")
                                             ),
                                    tabPanel("Plot",plotOutput("plot")),
                                    tabPanel("writeWav",
                                             p("The output file is now written, please wait a few seconds, then continue."),
                                             p("Please remember that you will probably have to restart the app in order to listen to the signal you have made"),
                                             plotOutput("plot2")
                                              ),
                                    tabPanel("Wav_output",
                                              p("Playing your sound, probably you have to restart the app"),
                                              tags$audio(src="audio.wav",type="audio/wav", controls=NA, autorepeat=NA)
                                              ),
                                    tabPanel("Wav_example1",
                                             p ("This is an example of beating or  howling wit 1 frequency at 100 Hz and  the other frequency at 101 Hz"),
                                             p("both with an amplitude of 10"),
                                             tags$audio(src="howling_100_101Hz.wav", type="audio/wav", controls = NA, autoplay =NA)
                                             ),
                                     tabPanel("Wav_example2",
                                             p ("This is an example of beating or howling with 1 frequency at 249 Hz and  the other frequency at 250 Hz"),
                                             p(" both with an amplitude of 10"),
                                              tags$audio(src="howling_249_250Hz.wav", type="audio/wav", controls = NA, autoplay =NA)
                                              ),
                                     tabPanel("Wav_example3",
                                              p ("This is an example of beating or  howling wit 1 frequency at 245 Hz and  the other frequency at 250 Hz"),
                                              p("both with an amplitude of 10"),
                                              tags$audio(src="howling_245_250Hz.wav", type="audio/wav", controls = NA, autoplay =NA)                               
                                              )
                                    )
                        )
                )
))