# pattern-recognition-with-matlab
Pattern recognition(Template matching) using background subtraction and extraction of local and global features.

Global and Local Features:

   Global features describe the image as a whole to the generalize the entire object. They include contour representations, shape              descriptors, and texture features.
    o Shape Matrices, Invariant Moments (Hu, Zernike), Histogram Oriented Gradients (HOG) and Co-HOG are some examples of global                  descriptors.
    o In this project, global features are used to track the moving objects in the fields using background subtraction.
  
   The local features describe the image patches (key points in the image) of an object. Local features represent the texture in an          image patch.
    o SIFT, SURF, LBP, BRISK, MSER and FREAK are some examples of local descriptors.
    o In this project, local features are used to recognise the pattern from the moving objects and use it to match with the snake                patterns already defined in the program.
 
 
The algorithms used-
    Moving object detection using background subtraction:
      o Background subtraction, also known as Foreground Detection, is a technique in the fields of image processing and computer vision            wherein an image’s foreground is extracted for further processing (object recognition etc.)
      o A foreground object is any entity that detected by producing difference of every frame of sequence to background model. This                result can be further used for tracking targets, motion detection.
 
    Extracting frames from the video:
      o This algorithm generates a series of images corresponding to specified frames of a given video file.
    
    Pattern Recognition using Template matching technique:
       o This is a widely used model in image processing to determine the similarity between two samples, pixels or curves to localize 
        and identify shapes in an image.
       o In this model, a template or a prototype of the pattern to be recognized is available. Each pixel of the template is matched              against the stored input image while considering all possible position in the input image, each possible rotation and scale                changes.
       o In visual pattern recognition, one compares the template to the input image by maximizing the spatial cross-correlation or by               minimizing a distance: that provides the matching rate.
       o After calculating the matching rate for every possibility, select the largest one which exceeds a predefined threshold.
 
 
    Once the motion is detected, then it captures the images and makes use of the classification algorithm to distinguish its                 characteristic features. Thus, once the snakes and animals are identified as dangerous using the classification methods and             produce alert buzzer in current location. The concerned people to safeguard themselves and also their agricultural lands.
