4. Apon first SSH into the instance, update apt and upgrade by running 
   `sudo apt update` and `sudo apt upgrade`. 

5. This will require a reboot to reset the headers.

7. Run `lspci | grep -i nvidia` to check if there actually is a gpu available.

8. Next we will install the GPU drivers. The steps are extremely important to 
   follow exactly.

9. Run `sudo apt install nvidia-driver-535`

10. Reboot the instance by doing the same thing we did above.

11. SSH back into the instance and run `nvidia-smi`. If this works then 
    continue. If there is
    an error message then maybe you messed up something from above. Ignore 
    the CUDA version that is illustrated in the `nvidia-smi` output. THIS 
    IS NOT THE CUDA VERSION INSTALLED, but the highest CUDA version that is 
    approved. The driver is backward compatible so older CUDA version will 
    still work.

12. Next we need to install the cuda toolkit. We will use 12.1 as this is 
    the most widely accepted version as of now.

2. Install some dependencies needed for the cuda tool kit with 
   `sudo apt-get install gcc make libboost-all-dev`

13. Run `mkdir -p ~/Software/cuda` and `cd` into this directory with 
    `cd ~/Software/cuda`.

14. Go to the 
    [cuda toolkit download](https://developer.nvidia.com/cuda-12-1-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=runfile_local)
    and choose the correct version of the toolkit. Select `runfile`(local)`. As of now, the
    commands are
    ```
    wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda_12.1.0_530.30.02_linux.run

    sudo sh cuda_12.1.0_530.30.02_linux.run
    ```

15. Installing with `sudo sh cuda_12.1.0_530.30.02_linux.run` will hang, so
    be patient.

16. There is going to be a warning message telling you to abort. Ignore it and 
    choose that you want to continue. After continuing, say that you accept.

17.1 NEXT MAKE SURE THAT YOU UNSELECT THE DRIVER!!!!!! You can use the arrow 
     keys to move around and use the enter key to select or de-delect. 
     ONLY AFTER DE-SELECTING THE DRIVER, use the arrows to move the install icon 
     and hit enter. The install hangs again, so be patient.

17.2 The following is the return of a successful installation
    ```
    ===========
    = Summary =
    ===========
    
    Driver:   Not Selected
    Toolkit:  Installed in /usr/local/cuda-12.1/
    
    Please make sure that
     -   PATH includes /usr/local/cuda-12.1/bin
     -   LD_LIBRARY_PATH includes /usr/local/cuda-12.1/lib64, or, add /usr/local/cuda-12.1/lib64 to /etc/ld.so.conf and run ldconfig as root
    
    To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-12.1/bin
    ***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 530.00 is required for CUDA 12.1 functionality to work.
    To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
        sudo <CudaInstaller>.run --silent --driver
    
    Logfile is /var/log/cuda-installer.log
    ```

18. Edit the `~/.bashrc` (or `~/.bash_profile` if you use that) and add the 
    follwing lines anywhere in these files:

    ```
    export PATH="/usr/local/cuda-12.1/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda-12.1/lib64:$LD_LIBRARY_PATH"
    ```

20. Run `echo "/usr/local/cuda-12.1/lib64" | sudo tee -a /etc/ld.so.conf' and also 
    `sudo ldconfig`

21. To check if thinks worked, you can run `ldconfig -p | grep cuda`. A bunch of stuff
    should appear.

22. Lastly, run `cat /usr/local/cuda/version.json | grep version -B 2`. The top of this
    output should say something like this:
    ```
    "cuda" : {
          "name" : "CUDA SDK",
          "version" : "12.1.20230222"
       },
    ```

23. If you run `nvcc --version` then you should get:
    ```
    nvcc: NVIDIA (R) Cuda compiler driver
    Copyright (c) 2005-2023 NVIDIA Corporation
    Built on Tue_Feb__7_19:32:13_PST_2023
    Cuda compilation tools, release 12.1, V12.1.66
    Build cuda_12.1.r12.1/compiler.32415258_0
    ```

24. One last check will be to see if cupy, numba and pytorch can access the GPU.

    ```
    pip install cupy-cuda12x
    pip install numba
    pip3 install torch torchvision torchaudio
    ```

    Lastly, create a python script and put the following into it and run it. 
    If the script returns all the affirmative responses then you are all good.

    ```
    """
    A simple test to see if the GPU is functional
    """
    
    try:
        import cupy
        print("cupy can be imported")
    except:
        print("cupy could not be imported")
    
    from numba.cuda import is_available as numba_works
    from torch.cuda import is_available as torch_works
    
    if numba_works():
        print("Numba cuda works")
    else:
        print("Numba does not work")
    
    if torch_works():
        print("torch cuda works")
    else:
        print("torch does not work")
    ```
