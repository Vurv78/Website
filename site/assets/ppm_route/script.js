// Absolutely awful code from who knows when.

function ppmRead(data,callback){
    const RegMatch = data.match(/(P3|P6)/);
    const Mode = RegMatch[0];
    const Offset = RegMatch.index+Mode.length+1

    if(Mode=="P3"){
      // P3
      const EditedPPM = data.substr(Offset);
      const SplitReg = new RegExp("\n| ");
      const FixedPPMData = EditedPPM.split(SplitReg);
      const Resolution = [FixedPPMData[0],FixedPPMData[1]];
      const ColorMode = FixedPPMData[2];
      FixedPPMData.splice(0,3)
      FixedPPMData.pop();
      if(ColorMode!="255"){
        callback("Can't do color mode other than 255.");
      }else{
        const SbPixelCount = Resolution[0]*Resolution[1];
        if(FixedPPMData.length==SbPixelCount*3){
          colors = [];
          for(Ind = 0 ; Ind<SbPixelCount ; Ind++){
            colors[Ind] = [FixedPPMData[Ind*3],FixedPPMData[Ind*3+1],FixedPPMData[Ind*3+2]];
          }
          callback(true,Resolution,ColorMode,colors);
          return true;
        }else{
          callback(false,"Number of pixels not equal to resolution.");
          return false;
        }
        //console.log("Resolution is: ",Resolution,"\nColor Mode is: ",ColorMode,"\nData is: ",FixedPPMData)
      }
      //console.log(Resolution[0],Resolution[1])
    }else if(Mode=="P6"){
      // P6
    }else{
      if(callback){
        callback("Invalid ppm mode given")
      }
      return false;
    }
  }

  const ppmCanvas = document.getElementById("ppmCanvas");
  const ctx = ppmCanvas.getContext("2d");
  ctx.imageSmoothingEnabled = false;
  const img = document.getElementById("defaultImage");
  ctx.drawImage(img, 0, 0,1280,720);
  const clearButton = document.getElementById("clearBtn");
  const resolutionLabel = document.getElementById("resLbl");
  resolutionLabel.innerHTML = "1280x720";

  clearButton.addEventListener("click",function(){
      ctx.clearRect(0,0,ppmCanvas.width,ppmCanvas.height);
  });

  Array.prototype.forEach.call(document.querySelectorAll('.file-upload__button'),function(btn)
  {
      const hiddenInput = btn.parentElement.querySelector('.file-upload__input');
      const spanLabel = btn.parentElement.querySelector('.file-upload__label');

      // set label text
      spanLabel.textContent = "No file selected";
      spanLabel.title = "No file selected";
      btn.addEventListener("click",function(){
         hiddenInput.click();
      });
      hiddenInput.addEventListener("change",function(){
          if(hiddenInput.value){
              const fileSelected = hiddenInput.files[0];
              const fileName = fileSelected.name;
              const fileType = fileName.split(".")[1];
              if(fileType=="ppm"){
                  spanLabel.textContent = fileName;
                  let reader = new FileReader();
                  reader.onload = function(){
                      let data = reader.result
                      ppmRead(data,function(success,resolution,colormode,colors){
                          if(success){
                              ppmCanvas.width = resolution[0];
                              ppmCanvas.height = resolution[1];
                              resolutionLabel.textContent = resolution[0]+"x"+resolution[1];
                              ctx.clearRect(0, 0, resolution[0],resolution[1]);
                              const resx = resolution[0]
                              const resy = resolution[0]
                              for(Ind = 0 ; Ind < colors.length ; Ind++){
                                  let Color = colors[Ind]
                                  ctx.fillStyle = "rgb("+Color[0]+","+Color[1]+","+Color[2]+")";
                                  ctx.fillRect(Ind%resx,Math.floor(Ind/resy),2,2);
                              }
                          }else{
                              alert("An error occurred when trying to parse the PPM file.\n" + resolution);
                          }
                      });
                  }
                  reader.readAsText(fileSelected);
              }else{
                  alert("Please select a .ppm file.")
              }
          }else{
              alert("File not selected!")
          }
      });
  });