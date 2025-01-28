import time

input("Press Enter to start the stopwatch")
start_time = time.time()

input("Press Enter to stop the stopwatch")
end_time = time.time()

elapsed_time = end_time - start_time

hours = int(elapsed_time // 3600)
minutes = int((elapsed_time % 3600) // 60)
seconds = int(elapsed_time % 60)

time_string = ""
if hours > 0:
    time_string += f"{hours}h "
if minutes > 0 or hours > 0:
    time_string += f"{minutes}m "
time_string += f"{seconds}s"

print(time_string.strip())
