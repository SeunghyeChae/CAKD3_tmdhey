SELECT * FROM PURPRD;

-- �� �Ӽ�����
SELECT * FROM CUST;

-- ����ä��- �¶���,����� :: �ֱ� 3���� 
SELECT ���޻�, SUM(�̿�Ƚ��) FROM CHANNEL
GROUP BY ���޻�;

-- ����� �̿� ��Ȳ
SELECT * FROM COMPUSE;

-- �����
SELECT ����ʸ�, COUNT(*) ���� FROM MEMBERSHIP
GROUP BY ����ʸ�;

-- ��ǰ �з�
SELECT * FROM PRODCAT;


SELECT ����ȣ, SUM(���űݾ�)
FROM PURPRD;

-- PURPRD :Ʈ����� ������ 
SELECT * FROM PURPRD;
SELECT ����ȣ, SUM(���űݾ�)
FROM PURPRD 
GROUP BY ����ȣ
