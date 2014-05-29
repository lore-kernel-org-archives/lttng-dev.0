From: tarek slaymia <tarek.slaymia@gmail.com>
Subject: lttng kretprobe issue
Date: Thu, 29 May 2014 15:53:10 -0400
Message-ID: <CAP7TvLcyae2tvJQCmE00=QfmteB4byyKRY+SDkeYaVjF3z5GeA__47260.4814953685$1401393264$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1231207019=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, lttng-dev-request@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1231207019==
Content-Type: multipart/alternative; boundary=047d7b3434b050c6f304fa8f47f6

--047d7b3434b050c6f304fa8f47f6
Content-Type: text/plain; charset=UTF-8

Hi all

when i replace a syscall function address for example sys_write using this
function in my LKM module :

xchg(&sys_call_table[__NR_write],my_own_write);

In the normal case the content of sys_call_table[__NR_write] address
changes and it displays the address of my_own_write using debug technique .

I have an issue when tracing this change using lttng kretprobe :

lttng enable-event sys_write -k --function sys_write

 The ip value of sys_write ( the same address of sys_call_table[__NR_write]
) remains the same even after changing it by the new function address
(address of my_own_write)
Why the ip value of sys_write syscall displayed in lttng traces remains the
same even after changing it ?

Best regards.

--047d7b3434b050c6f304fa8f47f6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi all<br><br></div>when i replac=
e a syscall function address for example sys_write using this function in m=
y LKM module :<br><br>xchg(&amp;sys_call_table[__NR_write],my_own_write);<b=
r>



<br></div>In the normal case the content of sys_call_table[__NR_write]=20
address changes and it displays the address of my_own_write using debug=20
technique .<br><br></div>I have an issue when tracing this change using ltt=
ng kretprobe :<br>
<br>
lttng enable-event sys_write -k --function sys_write<br>
<br>=C2=A0The ip value of sys_write ( the same address of=20
sys_call_table[__NR_write] ) remains the same even after changing it by=20
the new function address (address of my_own_write) <br></div>Why the ip val=
ue of sys_write syscall displayed in lttng traces remains the same even aft=
er changing it ? =C2=A0 <br>


<br></div>Best regards.</div>

--047d7b3434b050c6f304fa8f47f6--


--===============1231207019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1231207019==--
