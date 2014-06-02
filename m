From: tarek slaymia <tarek.slaymia@gmail.com>
Subject: lttng kretprobe issue
Date: Mon, 2 Jun 2014 16:12:33 -0400
Message-ID: <CAP7TvLdLYsyz-MfYq7CmwVsOXZCEva_d8D=pr-s7crnTNM32uw__25209.2733783231$1401740026$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0156660320=="
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

--===============0156660320==
Content-Type: multipart/alternative; boundary=089e01183d0afda8cb04fae00312

--089e01183d0afda8cb04fae00312
Content-Type: text/plain; charset=UTF-8

Hi all

i replace a syscall function address of sys_write by my_own_write function
using an LKM module as follow:

xchg(&sys_call_table[__NR_write],my_own_write);

In the normal case the content of sys_call_table[__NR_write] address
changes and it displays the address of my_own_write , i verify this using a
simple printk and i see that the address changes.

I have an issue when tracing this change using lttng kretprobe , i use the
following event :

lttng enable-event sys_write -k --function sys_write

 The ip value of sys_write in the lttng traces ( the same address of
sys_call_table[__NR_write] ) remains the same even after changing it by the
new function address (address of my_own_write)
Why the ip value of sys_write syscall displayed in lttng traces remains the
same even after changing it ?

Best regards.

--089e01183d0afda8cb04fae00312
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi all<br><br></div>i replace a s=
yscall function address of sys_write by my_own_write function using an LKM =
module as follow:<br><br>xchg(&amp;sys_call_table[__NR_write],my_own_write)=
;<br>




<br></div>In the normal case the content of sys_call_table[__NR_write]=20
address changes and it displays the address of my_own_write , i verify this=
 using a simple printk and i see that the address changes.<br><br></div>I h=
ave an issue when tracing this change using lttng kretprobe , i use the fol=
lowing event :<br>

<br>
lttng enable-event sys_write -k --function sys_write<br>
<br>=C2=A0The ip value of sys_write in the lttng traces ( the same address =
of=20
sys_call_table[__NR_write] ) remains the same even after changing it by=20
the new function address (address of my_own_write) <br></div>Why the ip val=
ue of sys_write syscall displayed in lttng traces remains the same even aft=
er changing it ? =C2=A0 <br>


<br></div>Best regards.<div class=3D"gmail_extra"><br></div></div>

--089e01183d0afda8cb04fae00312--


--===============0156660320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0156660320==--
