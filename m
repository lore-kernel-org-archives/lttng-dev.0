From: Matthew Khouzam via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: get function names with lttng-ust-cyg-profile
Date: Tue, 23 Jun 2020 15:12:10 +0000
Message-ID: <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
References: <20200623143758.GB4160129@jerryopenix>
Reply-To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0359904280060498912=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by lists.lttng.org (Postfix) with ESMTPS id 49rqWc0dgzz1368
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2020 11:12:11 -0400 (EDT)
In-Reply-To: <20200623143758.GB4160129@jerryopenix>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Liu, Changcheng" <changcheng.liu@intel.com>
List-Id: lttng-dev@lists.lttng.org

--===============0359904280060498912==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_"

--_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

You have the pointers that are traced. Babeltrace is doing exactly what it =
should as far as I know.

You could use the command 'nm' to get your symbols and look them up. I am s=
ure Babeltrace can do this from a python level. You could also use a GUI ba=
sed trace viewer to get the information.

Hope that helps.
Matthew
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Liu, Chang=
cheng via lttng-dev <lttng-dev@lists.lttng.org>
Sent: Tuesday, June 23, 2020 10:37 AM
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Cc: changcheng.liu@intel.com <changcheng.liu@intel.com>
Subject: [lttng-dev] get function names with lttng-ust-cyg-profile

Hi all,
   I'm trying to use lttng-ust-cyg-profile to trace program.
   Does anyone know how to get function names and offset through lttng-ust-=
cyg-profile?

   In below example, the babeltrace could only get the function entry/exit =
value.
   1. Source program: instrument.c
         1 #include <stdio.h>
         2
         3 int add3(int val) {
         4         return val + 3;
         5 }
         6
         7 int main(int argc, char **argv) {
         8     int x =3D 4;
         9
        10     puts("Press Enter to continue...");
        11     getchar();
        12
        13     x =3D add3(x);
        14
        15     return 0;
        16 }

   2. build source code:
        $ gcc -g -finstrument-functions instrument.c -o instrument

   3. run program:
       $ LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so=
 ./instrument

   4. start trace process:
       trace@trace:~/cc$ sudo lttng create instrument
       Session instrument created.
       Traces will be output to /root/lttng-traces/instrument-20200623-2229=
17

       trace@trace:~/cc$ sudo lttng enable-channel user_func_trace --usersp=
ace
       UST channel user_func_trace enabled for session instrument

       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_=
profile:func_entry --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_entry created in channel user_f=
unc_trace
       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_=
profile:func_exit --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_exit created in channel user_fu=
nc_trace

       trace@trace:~/cc$ sudo lttng start
       Tracing started for session instrument

       trace@trace:~/cc$ sudo lttng destroy
       Destroying session instrument..
       Session instrument destroyed

       trace@trace:~/cc$ sudo babeltrace /root/lttng-traces/instrument-2020=
0623-222917
       [22:29:55.388607059] (+?.?????????) trace lttng_ust_cyg_profile:func=
_entry: { cpu_id =3D 2 }, { addr =3D 0x5625C88B01A9, call_site =3D 0x5625C8=
8B0237 }
       [22:29:55.388612293] (+0.000005234) trace lttng_ust_cyg_profile:func=
_exit: { cpu_id =3D 2 }, { addr =3D 0x5625C88B01A9, call_site =3D 0x5625C88=
B0237 }
       [22:29:55.388613215] (+0.000000922) trace lttng_ust_cyg_profile:func=
_exit: { cpu_id =3D 2 }, { addr =3D 0x5625C88B01EE, call_site =3D 0x7FE40BD=
5C0B3 }

B.R.
Changcheng
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://protect2.fireeye.com/v1/url?k=3D98478753-c6e73d3d-9847c7c8-869a14f4=
b08c-41638b2508ab85dd&q=3D1&e=3D703483a0-63a9-4269-ac8e-c1fc5a57edad&u=3Dht=
tps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev

--_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You have the pointers that are traced. Babeltrace is doing exactly what it =
should as far as I know.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You could use the command 'nm' to get your symbols and look them up. I am s=
ure Babeltrace can do this from a python level. You could also use a GUI ba=
sed trace viewer to get the information.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hope that helps.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Matthew<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Liu, Changcheng via lttng-dev &=
lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> Tuesday, June 23, 2020 10:37 AM<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Cc:</b> changcheng.liu@intel.com &lt;changcheng.liu@intel.com&gt;<br>
<b>Subject:</b> [lttng-dev] get function names with lttng-ust-cyg-profile</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi all,<br>
&nbsp;&nbsp; I'm trying to use lttng-ust-cyg-profile to trace program.<br>
&nbsp;&nbsp; Does anyone know how to get function names and offset through =
lttng-ust-cyg-profile?<br>
<br>
&nbsp;&nbsp; In below example, the babeltrace could only get the function e=
ntry/exit value.<br>
&nbsp;&nbsp; 1. Source program: instrument.c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 #include &lt;stdio.h&gt;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 int add3(int val) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return val &#43; 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 int main(int argc, char =
**argv) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbsp;&nbsp;&nbsp; =
int x =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp; =
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10&nbsp;&nbsp;&nbsp;&nbsp; puts(=
&quot;Press Enter to continue...&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11&nbsp;&nbsp;&nbsp;&nbsp; getch=
ar();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13&nbsp;&nbsp;&nbsp;&nbsp; x =3D=
 add3(x);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 }<br>
<br>
&nbsp;&nbsp; 2. build source code:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ gcc -g -finstrument-functions =
instrument.c -o instrument<br>
<br>
&nbsp;&nbsp; 3. run program:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ LD_PRELOAD=3D/usr/lib/x86_64-linux-g=
nu/liblttng-ust-cyg-profile.so ./instrument<br>
<br>
&nbsp;&nbsp; 4. start trace process:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng create in=
strument<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Session instrument created.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Traces will be output to /root/lttng-t=
races/instrument-20200623-222917<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng enable-ch=
annel user_func_trace --userspace<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UST channel user_func_trace enabled fo=
r session instrument<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng enable-ev=
ent --userspace lttng_ust_cyg_profile:func_entry --channel user_func_trace<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UST event lttng_ust_cyg_profile:func_e=
ntry created in channel user_func_trace<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng enable-ev=
ent --userspace lttng_ust_cyg_profile:func_exit --channel user_func_trace<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UST event lttng_ust_cyg_profile:func_e=
xit created in channel user_func_trace<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng start<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tracing started for session instrument=
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng destroy<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Destroying session instrument..<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Session instrument destroyed<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo babeltrace /roo=
t/lttng-traces/instrument-20200623-222917<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [22:29:55.388607059] (&#43;?.?????????=
) trace lttng_ust_cyg_profile:func_entry: { cpu_id =3D 2 }, { addr =3D 0x56=
25C88B01A9, call_site =3D 0x5625C88B0237 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [22:29:55.388612293] (&#43;0.000005234=
) trace lttng_ust_cyg_profile:func_exit: { cpu_id =3D 2 }, { addr =3D 0x562=
5C88B01A9, call_site =3D 0x5625C88B0237 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [22:29:55.388613215] (&#43;0.000000922=
) trace lttng_ust_cyg_profile:func_exit: { cpu_id =3D 2 }, { addr =3D 0x562=
5C88B01EE, call_site =3D 0x7FE40BD5C0B3 }<br>
<br>
B.R.<br>
Changcheng<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
<a href=3D"https://protect2.fireeye.com/v1/url?k=3D98478753-c6e73d3d-9847c7=
c8-869a14f4b08c-41638b2508ab85dd&amp;q=3D1&amp;e=3D703483a0-63a9-4269-ac8e-=
c1fc5a57edad&amp;u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Fli=
stinfo%2Flttng-dev">https://protect2.fireeye.com/v1/url?k=3D98478753-c6e73d=
3d-9847c7c8-869a14f4b08c-41638b2508ab85dd&amp;q=3D1&amp;e=3D703483a0-63a9-4=
269-ac8e-c1fc5a57edad&amp;u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmai=
lman%2Flistinfo%2Flttng-dev</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_--

--===============0359904280060498912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0359904280060498912==--
