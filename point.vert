#version 150 core
#extension GL_ARB_explicit_attrib_location : enable

// ���_����
layout (location = 0) in vec4 pv;                   // ���[�J�����W�n�̒��_�ʒu

void main(void)
{
  gl_Position = pv;
}
