from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import subprocess
app = FastAPI()
# Request model for sustainability flags
class SustainabilityRequest(BaseModel):
    product_name: str
# Request model for eco score
class EcoScoreRequest(BaseModel):
    product_data: dict
@app.post("/get_sustainability_flags")
def get_sustainability_flags(request: SustainabilityRequest):
    try:
        result = subprocess.run(
            ["python", "generate_sustainability_flags.py", request.product_name],
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            raise HTTPException(status_code=500, detail=f"Error: {result.stderr}")
        
        return {"product_name": request.product_name, "sustainability_flags": result.stdout.strip()}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
@app.post("/get_eco_score")
def get_eco_score(request: EcoScoreRequest):
    try:
        # Assume generate_eco_score.py takes a JSON string as input
        product_data_str = str(request.product_data)
        result = subprocess.run(
            ["python", "generate_eco_score.py", product_data_str],
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            raise HTTPException(status_code=500, detail=f"Error: {result.stderr}")
        
        return {"eco_score": result.stdout.strip()}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
