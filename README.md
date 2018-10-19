# Capstone Project - Speaker Classification

# Executive Summary
We see voice being used more and more in our daily devices, whether it be to get information on traffic, order pizza, or to hear a lame joke. A number of these systems now have speaker recognition and devices like the Google Home and Amazon Alexa can respond to each user accordingly.
The objective of my project was to be able to create a system that could classify the voices of three people at a rate better than chance. I was hoping for classification model to have an accuracy of at least 60%. 
 I found a [blog](https://towardsdatascience.com/automatic-speaker-recognition-using-transfer-learning-6fab63e34e74) that outlined a method for doing such a task. They also provided to links to open source audiobooks they had downloaded for their model.

## Data
I downloaded the zip files of around 100 audiobooks, all of which were split up in chapters. Audiobooks are ideal audio sources since they consist of single speaker speaking for hours with little to no noise. <br>
    
## Processing
For processing each audiobook I followed this process. I used command line tools like ffmpeg, sox, and mp3wrap.<br>

1.Using mp3wrap, combine audio files from a single book since they were split up into chapters.<br>
2.Using ffmpeg, cut each audio file down to 45min<br>
3.Using ffmpeg, convert each audio file from mp3 to wav.<br>
4.Remove silence longer than 0.5 seconds using sox.<br>
5.Split each wav file into 5 second segments using ffmpeg.<br>
6.Convert each segment into a spectrogram using sox to input into a convolutional neural network . A spectrogram is a visual representation of a spectrum of frequencies of over time. As shown below.<br>
<br>

<img src="ex_spec.png" width="400" height="256"></img>
    
## Modeling
For modeling I used a Convolutional Neural Network trained on six people, then I used transfer learning to take features extracted from the CNN to use as inputs for an SVM model. Before inputting the images into the model I also reduced the size of each image to 25% of the original size.<br> 
The architecture of the model was in the order as follows: <br>
1. 2 convolutional layers with a kernel size of 5x5 with a relu activation function<br>
2. Maxpooling layer with 2x2 kernel<br>
3. Dropout layer of 0.25<br>
4. 2 convolutional layers with a kernel size of 3x3 with a relu activation function<br>
5. Maxpooling layer with 2x2 kernel<br>
6. Flatten layer with relu activation<br>
7. A final dense layer with nodes equal to the amount of people being classified<br>

After this training has been done, I implement transfer learning with the features extracted from the CNN to use as inputs to the SVM.
I use an SVM since I want to be able to classify new people with the model I trained but I don't want to have to retrain the model everytime. An SVM can classify well when given a lot of features but not so many data points which makes it ideal for this scenario.<br>

The way transfer learning is implemented is to take the trained model , cut off the last classification layers and attach it to another neural network or machine-learning architecture. This technique is widely used in computer vision and natural language processing as a starting point for models that are doing similar tasks. From here models are either retrained, repurposed, and/or used as feature extractors.<br>

## Limitations
I was hoping to train the model on at 50 audiobooks but due to time-constraints and memory issues, I was unable to process all the audio spectorgrams. 50 models would have been optimal since the network would be able to capture more voices. Also an SVM's runtime in O(n^3) so if I load too much data , it will take a long time to train. <br>

## Results
After training the CNN on spectrograms from 6 people, I got a training accuracy of 99% and a validation accuracy of 88%. 
Using this trained CNN as a feature extractor, I used an SVM to learn the features of 3 new speakers from different audio books. The results came to around 62%. <br>

<img src="conf.PNG"></img>    
<br>

You can see that the predictions for the 1st and 3rd speaker are pretty good, but the 2nd speaker never gets classified. I am suspecting that it may be because the model is too biased and or at some point the author does voices. 
    
    
    
