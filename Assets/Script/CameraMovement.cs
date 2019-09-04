using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement : MonoBehaviour {
    public float speed;
    public float turnSpeed;
	// Use this for initialization
	void Start () {
        speed = 400.0f;
        turnSpeed = 200.0f;
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKey(KeyCode.UpArrow))
        {
            transform.Translate(Vector3.forward * speed * Time.deltaTime);
        }
        if(Input.GetKey(KeyCode.DownArrow))
            {
            transform.Translate(-Vector3.forward * speed * Time.deltaTime);
        }
        if(Input.GetKey(KeyCode.RightArrow))
        {
            transform.Translate(-Vector3.left * speed * Time.deltaTime);
        }
        if(Input.GetKey(KeyCode.LeftArrow))
        {
            transform.Translate(Vector3.left *speed* Time.deltaTime);
        }
        if(Input.GetKey(KeyCode.A))
        {
            transform.Rotate(-Vector3.up * turnSpeed * Time.deltaTime);
        }
        if(Input.GetKey(KeyCode.D))
        {
            transform.Rotate(Vector3.up * turnSpeed * Time.deltaTime);
        }
	}
}
