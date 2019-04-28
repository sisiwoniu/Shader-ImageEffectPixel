using UnityEngine;

public class PostProcess : MonoBehaviour {

    public Material PostprocessMaterial;

    public RenderTexture CameraRT;

    private void Start() {
        //Camera.main.depthTextureMode = DepthTextureMode.DepthNormals;

        CameraRT = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.ARGBHalf);

        Camera.main.targetTexture = CameraRT;
    }

    //カメラごとにレンダリング完了したら呼ばれる
    private void OnPostRender() {

        //Graphics.RenderTarget(null);と同じ
        RenderTexture.active = null;

        Graphics.Blit(CameraRT, PostprocessMaterial);
    }
}