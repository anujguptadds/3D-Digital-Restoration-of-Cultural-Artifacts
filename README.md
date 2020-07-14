# 3D-Digital-Restoration-of-Cultural-Artifacts

### Motivation
- Analyzing the topography of artifacts and monuments physically has always been a challenging task due to various difficulties such as large sizes and complex structures
- Reconstructing a 3D digital model on a computer will be beneficial 
- Analysis using software medium would result in faster and more accurate results
- We use Fringe Projection Profilometry (FPP) for this purpose

### Procedure
- Projecting fringes on the object to be reconstructed digitally
- Capturing the distorted fringes and applying phase wrapping algorithm 
- Implement phase unwrapping on the obtained wrapped phase to achieve the final reconstruction

### Fringe Projection
- In general profilometry, a fringe pattern consists of fringes of sinusoidal nature, having some specific frequency
- Fringes are distorted upon falling on the object surface
- The nature of distortions depends upon the shape of the object surface
- Hence, we capture these distortions and intend to gather the shape information for the digital restoration

### Obtaining Wrapped Phase (Using Phase Shifting Profilometry)
- Multiple fringe patterns are required to produce the wrapped phase
- The fringe patterns are phase shifted by a value 2π/N, N being the total number of patterns 
- This method is more accurate as compared to others (such as Fringe Transform Profilometry)
- Absolute wrapped phase is obtained using the values of the intensities of the distorted fringe maps at each pixel 
- True wrapped phase is obtained by removing the reference

### Need for Unwrapping
- The wrapped phase obtained by the above methods is not accurate
- The phase values obtained lies in the range [-π , π] due to the arc-tangent function used for extracting the wrapped phase
- Hence, the phase discontinuities occur at the limits every time when the unknown true phase changes by 2π

### Obtaining Unwrapped Phase
We have implemented the unwrapping of the obtained wrapped phase through the following methods:
- Multi–Frequency method
- Number–Theory method
- High–Speed Profilometry method

### Multi – Frequency Method
- This is a temporal phase unwrapping algorithm
- Unwrapping at each pixel is done independent of the others
- Hence, we obtain accurate reconstructions for discontinuities as well
- We used two wrapped phases with two distinct frequencies (using PSP), with one of the frequencies being less than unity 
- The fringe order at each pixel is calculated using the wrapped phase values and the two frequencies 
- The unwrapped phase is then obtained by adding the fringe order, after multiplying it with a factor of 2π, to the wrapped phase at each pixel

### Number – Theory Method
- Classified as a temporal phase unwrapping method
- Similar to multi-frequency, requires two wrapped phase maps (using PSP) corresponding to two distinct frequencies
- Based on the fact that if we choose two wavelengths, we obtain a unique wrapped phase pair on the absolute phase axis till a specific range
- This range is determined by the LCM of the chosen wavelengths
- Hence, a Look-Up-Table is created, mapping the wrapped phase pair (corresponding to the two frequencies) to the fringe orders
- Using LUT, the fringe order at each pixel is determined by the wrapped phase values at that pixel, as well as the frequencies (or wavelengths)
- Hence, the unwrapping is done by adding this fringe order (multiplied by 2π) to the wrapped phase value

### High – Speed Profilometry
- Another temporal phase unwrapping algorithm
- More suitable for real-time applications as it requires only four fringe patterns (instead of six, three per wrapped phase, in the previous temporal methods)
- Out of the four patterns, two are sinusoidal, while two are linear
- Only one wrapped phase, along with a base phase required for unwrapping
- Both the wrapped and the base phases are obtained through the common combination of the four distorted fringe patterns
- The unwrapped phase value at each pixel is evaluated based on the wrapped phase, base phase , and the chosen frequency values

You can find attached the results of the reconstructions for the peaks surface (available in Matlab), and a cuboid object.
