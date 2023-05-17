from pdf2image import convert_from_path
import numpy as np
import cv2

images = convert_from_path(
    r"D:\github_repo\flutter_windows_desktop\assets\changelog\changelog.pdf",
    output_folder=r"D:\github_repo\flutter_windows_desktop\assets\changelog",
    output_file="a",
    fmt="png")

cv_images = []

for i in images:
    cv_images.append(np.asarray(i))

img = cv2.vconcat(cv_images)
img = cv2.cvtColor(img,cv2.COLOR_RGB2BGR)

cv2.imwrite(
    r"D:\github_repo\flutter_windows_desktop\assets\changelog\changelog.png", img)
