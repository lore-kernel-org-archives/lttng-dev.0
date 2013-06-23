From: Jessica Foest <jessica.foest@gmail.com>
Subject: New LTTNG user : Question about Kprobe and function
	commandline options
Date: Sun, 23 Jun 2013 00:19:30 -0400
Message-ID: <CAPxN80BVxGkHob1CcQOZcSBcskiN5p3yC78+O5PHSSRr1HU=FA__25113.6619401679$1371961212$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0100446594=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev-request@lists.lttng.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0100446594==
Content-Type: multipart/alternative; boundary=089e013a15263db80804dfca9afa

--089e013a15263db80804dfca9afa
Content-Type: text/plain; charset=ISO-8859-1

Hi,
i tried to apply kprobe to a system call , so i used probe and function
option :

lttng enable-event aname -k --probe sys_open+0x0
this command returns ip value

lttng enable-event aname -k --function sys_open
this command returns ip and parent_ip values .

what does these values ip and parent_ip means ?

I try to apply probe and function options to some kernel symbols like
initialized date (like xen_vcpu_info symbol), read only data (like
linux_prob_banner symbol) and code (like reserve_ebda_region symbol) it
displays to me : Enable kernel event failed ,warning some command went(s)
wrong.
Did i make a mistake or it's a limitation in LTTng ?
regards.

--089e013a15263db80804dfca9afa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>i tried to apply kprobe to a system call , so i use=
d probe and function option : <br><br>lttng enable-event aname -k --probe s=
ys_open+0x0 <br>this command returns ip value <br><br>lttng enable-event an=
ame -k --function sys_open<br>
this command returns ip and parent_ip values .<br><br>what does these value=
s ip and parent_ip means ?<br><br>I try to apply probe and function options=
 to some kernel symbols like initialized date (like xen_vcpu_info symbol), =
read only data (like linux_prob_banner symbol) and code (like reserve_ebda_=
region symbol) it displays to me : Enable kernel event failed ,warning some=
 command went(s) wrong.<br>
Did i make a mistake or it&#39;s a limitation in LTTng ?<br>regards.<br></d=
iv>

--089e013a15263db80804dfca9afa--


--===============0100446594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0100446594==--
