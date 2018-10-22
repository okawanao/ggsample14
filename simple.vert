#version 150 core
#extension GL_ARB_explicit_attrib_location : enable

// ����
uniform vec4 lamb;                                    // ��������
uniform vec4 ldiff;                                   // �g�U���ˌ�����
uniform vec4 lspec;                                   // ���ʔ��ˌ�����
uniform vec4 lpos;                                    // �ʒu

// �ގ�
uniform vec4 kamb;                                    // �����̔��ˌW��
uniform vec4 kdiff;                                   // �g�U���ˌW��
uniform vec4 kspec;                                   // ���ʔ��ˌW��
uniform float kshi;                                   // �P���W��

// �ϊ��s��
uniform mat4 mv;                                      // ���f���r���[�ϊ��s��
uniform mat4 mp;                                      // ���e�ϊ��s��
uniform mat4 mn;                                      // �@���x�N�g���̕ϊ��s��

// ���_����
layout (location = 0) in vec4 pv;                     // ���[�J�����W�n�̒��_�ʒu
layout (location = 1) in vec4 nv;                     // ���_�̖@���x�N�g��

// ���X�^���C�U�ɑ��钸�_����
out vec4 iamb;                                        // �����̔��ˌ����x
out vec4 idiff;                                       // �g�U���ˌ����x
out vec4 ispec;                                       // ���ʔ��ˌ����x

void main(void)
{
  vec4 p = mv * pv;                                   // ���_���W�n�̒��_�̈ʒu
  vec3 v = -normalize(p.xyz / p.w);                   // �����x�N�g��
  vec3 l = normalize((lpos * p.w - p * lpos.w).xyz);  // �����x�N�g��
  vec3 n = normalize((mn * nv).xyz);                  // �@���x�N�g��
  vec3 h = normalize(l + v);                          // ���ԃx�N�g��

  iamb = kamb * lamb;
  idiff = max(dot(n, l), 0.0) * kdiff * ldiff;
  ispec = pow(max(dot(n, h), 0.0), kshi) * kspec * lspec;

  gl_Position = mp * p;
}
