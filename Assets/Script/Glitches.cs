using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Glitches : MonoBehaviour
{
    public float GlitchesChance;
    private Renderer shader;
    private WaitForSeconds glitchLoopWait = new WaitForSeconds(.1f);
    private WaitForSeconds glitchLoopDuration = new WaitForSeconds(.1f);
    private void Awake()
    {
        shader = GetComponent<Renderer>();
    }
    IEnumerator Start()
    {
        while (true)
        {
            float glitchTest = Random.Range(0.0f, 1.0f);
            if (glitchTest <= GlitchesChance)
            {
                StartCoroutine(Glitch());
            }
            yield return glitchLoopWait;
        }
    }
    IEnumerator Glitch()
    {
        glitchLoopDuration = new WaitForSeconds(Random.Range(0.5f, .25f));
        shader.material.SetFloat("_Amount", 1f);
        shader.material.SetFloat("_CutoutTresh", .1f);
        shader.material.SetFloat("_Amplitude", Random.Range(100, 250));
        shader.material.SetFloat("_speed", Random.Range(1, 10));
        yield return glitchLoopDuration;
        shader.material.SetFloat("_Amount", 0f);
        shader.material.SetFloat("_cutoutTresh", 0f);
    }
}
