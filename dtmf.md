# DTMF Analysis

We first take a spectrogram of the signal with 1024 bins (50% overlap), and find the peaks above half the signal range, with a minimum distance of 2 between peaks.

For each peak, if it comes within a certain distance of a target frequency, we mark that frequency as being in the signal.

Doing this for the "low" and "high" frequencies gives us the final key. Keeping track of when the key changes lets us know the start/end of each key.
