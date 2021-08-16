-----------------------------------------------------------------------------
	���̺�
-----------------------------------------------------------------------------

�� �ڷ���
�� ����Ÿ��
    char	������ ����Ÿ��		
		2000byte ���� ���� ����. 
		������ ���� ���� ª�� �����Ͱ� �� ��� ������ ������ �������� ä���.
				    			
    varchar2	������ ����Ÿ��
		4000byte ���� ���� ����.	
		������ ���� ���� ª�� �����Ͱ� �� ��� ������ ���̸�ŭ ������ �����ȴ�.

    LOB		�ؽ�Ʈ �׷��� �̹��� ������ ����� ���� ����ȭ ���� ���� ��뷮 �����͸� ����
		4GB���� ���� ����.
		BLOB 			���̳ʸ� ������ 
		CLOB 			��뷮 �ؽ�Ʈ ������ 
		NCLOB			������ ���ڼ� �����͸� ����
		BFILE 			��뷮 ���̳ʸ� �����͸� ���� ���·� ����
 
    Nchar , Nvarchar2	ũ���� ������ Byte�� �ƴ϶� ���ڼ��� ��Ÿ��

�� ����Ÿ�� 		
    number (���� �� �Ǽ� ��� ����)
    number(5) 		-> -99999 ~ 99999
    number(3) 		-> -999 ~ 999
    number(5,2) 	-> -999.99 ~ 999.99
    number(6,3) 	-> -999.999 ~ 999.999
	
�� ��¥Ÿ��
    date
    timestamp		date�� Ȯ������

�� ���ڵ�
    ASCII
    ����/����/��ȣ 1���ڴ� 1����Ʈ, �ѱ�/���� 1���ڴ� 2����Ʈ
    ������ �� �ٸ� �ϳ��� �� ����� �� �ֽ��ϴ�.
    �ϳ��� ���Ͽ� ���� �� ���ÿ� ǥ���� �� �����ϴ�.
    ��ǻ�� ��â����� ����� �Ա⿡, ȣȯ���� �����ϴ�.

    euc-kr
    ����/����/��ȣ 1���ڴ� 1����Ʈ, �ѱ�/���� 1���ڴ� 2����Ʈ
    ����, �ѱ�, �ѱ����� ���Ǵ� ���ڸ� ǥ��. ��, Ư�� �ܱ��� ����, �Ϻ���/�߱��� ���ڴ� ǥ���� �� �����ϴ�.
    �ϳ��� ���Ͽ� ���� �� ���ÿ� ǥ���� �� �����ϴ�.
    ��ǻ�� ��â����� ����� �Ա⿡, ȣȯ���� �����ϴ�. 

    Unicode	
    �� ����� ������ ���ڼ��� ���� �ֽ��ϴ�. �ѱ��� KSC5601.
    �� ������ ���ڼ��� ǥ��ȭ�� ������� �����ڵ�.
		
    ����/����/��ȣ/�ѱ�/���� 1���ڴ� 2����Ʈ, ���Ͽ� ����ÿ��� 2����Ʈ
    ��� �� ǥ�� �����մϴ�.
    �ϳ��� ���Ͽ� ��� �� ǥ���� �� �ֽ��ϴ�. �� �� �� ���� ��Ʈ�� ��ġ�Ǿ� �־�� �����մϴ�.

    UTF-8
    1byte ��ݿ��� Ȯ��	. ASCII�� ȣȯ�� ���� 1byte�� ����.	
    ����/����/��ȣ 1���ڴ� 1����Ʈ, �ѱ�/���� 1���ڴ� 3����Ʈ, ���Ͽ� ����ÿ��� 3����Ʈ
    ��� �� ǥ�� �����մϴ�. 
    �ϳ��� ���Ͽ� ��� �� ǥ���� �� �ֽ��ϴ�. �� �� �� ���� ��Ʈ�� ��ġ�Ǿ� �־�� �����մϴ�.
  
    UTF-16
    2byte ��ݿ��� Ȯ��. �Ѵ� ���ڴ� 4byte
    ����/����/��ȣ/�ѱ�/���� 1���ڴ� 2����Ʈ
    ��� 2byte�� ǥ���Ǵ� ������ �ִ�.


-----------------------------------------------------------------------------
	DDL
-----------------------------------------------------------------------------

�� DDL Data Definition Language
�� ���̺� ����
    create table ���̺��( �÷��� �ڷ��� );

    create table test1 (
	eno number( 4 ),
	ename varchar2( 20 ),
	esal number( 7, 2 )
    );

�� ���̺� ����
    create table test2 as select * from test1;
    �ٸ� ���̺��� ���� �Ӿƴ϶� �����ͱ��� �����ؼ� ���ο� ���̺� ����
    ���� ���̺��� �÷��� �����ؼ� ������ ���� �ִ�.

�� ���̺� ���� ����
    create table test3 as select * from test1 where 1=0;
    where �������� ���� ������ �����ϸ� �ش� �ο츦 �߰����� ���ϱ� ������ 
    �ο찡 ���� �� ���̺��� �����Ѵ�.
		
�� �÷� �߰��ϱ�
    alter table test1 add( email varchar2( 10 ) );
	
�� �÷� �����ϱ�	
    alter table test1 modify( email varchar2( 40 ) );
	
    �����Ͱ� ������ ��� ������ Ÿ���� ������ �� ����. 
    �� char�� varchar2 �� �����ϴ�.
    ũ��� ���� �����ͺ��� ���ų� ũ�� ���游 �����ϴ�.

�� �÷� �����ϱ�
    alter table test1 drop column email;
	
�� �÷� ��Ȱ��ȭ
    alter table test1 set unused( email );
    �÷��� ������ ��� ������� ���� �ֱ� ������ 
    �ϴ� �������� ������ �� ���󵵰� ���� �ð��� ���� ���� �۾��� �Ѵ�.
    delete�� ���� �ٽ� ����� �� ����.

    select * from user_unused_col_tabs;
    �÷� ���� Ȯ��	

    alter table test1 drop unused columns;
    unused column ��� ����

�� ���̺��� ��� �ο� ����
    truncate table test1;
	
�� ���̺� ����
    drop table test1;

	
-----------------------------------------------------------------------------
	DML
-----------------------------------------------------------------------------

�� DML Data Manipulation Language
�� insert
    ���̺� �����͸� �Է��ϱ� ���� ����ϴ� ������ ���۾�

    insert into ���̺�� [�÷���] values [��]
    �÷��� ����� ��ϼ��� values ������ ������ ���� ������ ���ƾ� �Ѵ�.
    ���̺��� ��� �÷��� �� �Է��ϴ� ���� �÷����� ������� �ʴ´�.
    �÷���� ���� �����ϴ� ��� �ش� �÷����� NULL ���� �Էµ˴ϴ�.
    NULL���� ���������ϰų� ������ ��� ����ϴ� �͵� �����ϴ�.
	
    insert into test1 select * from test2;
    �ٸ� ���̺��� ���ϵǴ� �ο� ����ŭ ���̺� �߰��Ѵ�.

    create table commission(
    employee_id number( 3 ),
    bonus number( 8, 2)
    );
    insert into commission select employee_id, salary * 0.1 from employees;

    ���� ���̺� �� ���� insert
    create table employees80 as select * from employees where 0=1;
    create table employees90 as select * from employees80;
    create table employees100 as select * from employees90;

    select * from employees80;	�����Ͱ� ����
    select * from employees90;	�����Ͱ� ����
    select * from employees100;	�����Ͱ� ����

    INSERT [ALL or FIRST]	
	WHEN ����1 THEN INTO ���̺��1
	WHEN ����2 THEN INTO ���̺��2
	...
	ELSE INTO ���̺��0
    SELECT ����;

    all�� first�� ���̴� �������� �߻��� ���
    all�� ���� ���� ��ο� �����͸� �ְ�
    first�� ���� ���ǿ��� �����͸� �ִ´�.

    insert all
    when department_id = 80 then into employees80 
    when department_id = 90 then into employees90 
    when department_id = 100 then into employees100
    select * from employees; 

    select * from employees80;
    select * from employees90;
    select * from employees100;

�� update
    update ���̺�� set �÷���=������ �� where ����

    update test1 set ( dname, loc ) = ( select dname, loc from test2 where deptno=40 ) where deptno=20;
    �ٸ� ���̺��� ���� �̿��ؼ� �� �����ϱ�

    update test set esal 
    = ( select salary from employees where last_name = 'Seo' )
    where esal is null;

�� delete
    delete from ���̺�� where ����
	
    delete from test1 where deptno = ( select deptno from test2 where dname=��sales�� );
    ���� ���̺� �μ����� ���� ��� �ٸ� ���̺��� �μ������� �μ���ȣ�� �˻��ؼ� ���� ���̺� �����Ѵ�.


-----------------------------------------------------------------------------
	Ʈ�����
-----------------------------------------------------------------------------

�� Ʈ����� ����	
    Ʈ����� ������ ó���� �� ������ �ǹ��Ѵ�.
    �ϳ��� Ʈ������� All-Or-Nothing ������� ó���ȴ�.
    ���� ���� ����� ��� ���������� ó���Ǹ� ���� ���� �ϰ�
    �ϳ��� ������������ ó���Ǹ� ��θ� ����Ѵ�.

    commit		������� ���� ��� �����ͺ��̽��� �����ϰ� ������ Ʈ������� �����Ѵ�.
			Ʈ����� ó�������� ��� �ݿ��Ǹ� �ϳ��� Ʈ����� ������ ������.
    savepoint �̸�;	��������� Ʈ������� Ư�� �̸����� �����ϴ� ���
    rollback [to �̸�]	������� ���� �����͸� ��� ����ϰ� Ʈ������� �����Ѵ�.
			savepoint �� ������ ��ġ�� ���ư���.
	
    create alter drop ���� �ڵ� Ŀ���� �߻��Ѵ�.
	

-----------------------------------------------------------------------------
	���� ���� Constraints
-----------------------------------------------------------------------------

�� ���Ἲ ���� ����
    ���̺� �������� �ڷᰡ �ԷµǴ� ���� �����ϱ� ���� ���̺��� ������ �� �÷��� �����ϴ� ��Ģ

    not null	�ش� �÷� ������ NULL�� ������� �ʴ´�.
    unique	�ش� �÷� ���� �׻� ���Ϲ����� ���� ������.
    primary key	�ش� �÷� ���� �ݵ�� �����ؾ� �ϰ� �����ؾ� �Ѵ�.
		not null�� unique�� ������ ����
    foreign key	�ش� �÷� ���� Ÿ �÷��� ���� �����ؾ� �Ѵ�.
		�����Ǵ� �÷��� ���� ���� �Է� �Ұ�
    check	�ش� �÷��� ���� ������ ������ ���� ������ ����� ������ ����

    ���� ���� Ȯ���ϱ�
    select * from user_constraints;

    P 		primary key
    R 		foreign key
    C 		check, not null

    �������� �̸��� ���̺��_�÷���_���� ���� ���� ������ ���Ѵ�.
    pk		primary key
    fk		foreign key
    nn		not null
    uk    	unique
    ck		check

    �������� �̸� ����
    alter table table_name RENAME CONSTRAINTS 
    old_constraint_name TO new_constraint_name;
    
    ���� ���� �����ϱ�	
    alter table test drop constraint test1_name_pk;
   
    create table test1 (
	id number( 3 ) primary key, 
	name varchar2( 10 ) not null,
	tel varchar2( 10 ),
	address varchar2( 50 )
    );

�� not null ���� ����
    name varchar2(10) constraint test1_name_nn not null,
	
    ���� ���̺��� �÷��� not null �� ������ ���� 
    alter table ~ add constraint ~�� ����� �� ����.
    not null ������ �߰��ϴ� ���� �ƴ϶� null �� ���¸� not null �� �ٲٴ� ���̴�.

    alter table test1 modify name constraint test1_name_nn not null;

�� �⺻Ű ���� ����
    �⺻ Ű �÷����� NULL ���� �� �� ������ �ߺ� �� �� ����.   

    id varchar2(10) constraint test1_id_pk primary key,	

    alter table test1 add constraint test1_id_pk primary key(id);
    alter table test1 drop constraint test1_id_pk;

�� ����Ű ��������
    UNIQUE ���� ������ �����ϸ� �ߺ� ���� ������� �ʴ´�. 
    �ϳ��� ���̺� ���� ���� ������ �� �ִ�.
    �� NULL�� ���� �ƴϱ� ������ ���� ���� �����ϴ�.

    name varchar2(10) constraint test2_name_uk unique,

    alter table test1 add constraint test1_email_uk unique(email);
    alter table test1 drop constraint test1_email_uk;

�� check ���� ����
    �����͸� �˻��Ͽ� Ư�� ���ǿ� �´� �����͸� �Է��ϵ��� ���� �Ѵ�.

    age number constraint test1_age_ck check( age between 0 and 150 ),

    alter table test1 add constraint test1_sal_ck check( sal between 0 and 20000 );
    alter table test1 drop constraint test1_sal_ck;

�� �������Ἲ
    create table depart (
	deno number primary key,
	dename varchar2( 30 ) unique
    );

    �μ� ���̺� �μ���ȣ�� 10 20 30 40�� �����Ѵٸ�
    ��� ���̺� �����ϴ� �μ���ȣ�� �ݵ�� �μ� ���̺��� �μ� ��ȣ ���� ��ȣ�� ������ �Ѵ�.
    �̷� ��� ��� ���̺��� �μ� ���̺��� �����ϴ� ���Ӱ��谡 �����ȴ�.
    ��� ���̺��� �ڽ� ���̺��� �ǰ� �μ� ���̺��� �θ� ���̺��� �ȴ�.

    ��� ���̺��� �μ���ȣ �÷��� �ܷ�Ű�� �ϰ� �μ� ���̺��� �μ���ȣ �÷��� �θ�Ű�� �ȴ�.
    �μ���ȣ �÷��� �θ�Ű�� �Ƿ��� UNIQUE ���� �������� �����Ǿ�� �Ѵ�.

    ���� �ԷµǴ� ��������� �μ���ȣ�� �θ�Ű�� �������� �ʴ� ��ȣ��� 
    ���Ἲ ���� ���ǿ� ����ȴٴ� ������ �߻��Ѵ�.

    create table test2(
	...
	deno varchar2(10) references depart( deno ),
	...
    );
    test1 ���̺��� deno �÷��� �����ϴ� �ܷ�Ű�� �����Ѵ�.
    ���� ���Ǹ��� ������ ���� ��� ����Ŭ ���� �������Ǹ��� ���δ�.

    deno varchar2(10) constraint test2_deno_fk references depart( deno ),
    ���� ���Ǹ��� ���� �ٿ��ش�.

    alter table test2 add constraint test2_deno_fk foreign key(deno) references depart( deno );

�� cascade
    ���� ���Ἲ �������� ſ�� �⺻Ű�� ���� ���̺��� �������� �ʴ� ���� 
    �� �ڿ� cascade �ɼ��� �����Ѵ�.

    drop table depart cascade constraint;

    select * from user_constraints where table_name = 'DBTEST';
    �θ�Ű�� ���� ���̺��� �����Ǹ� �������ǵ� �����ȴ�.