From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: Extracting System Call IDs By Using TMF
Date: Sat, 30 Nov 2013 20:23:58 -0500
Message-ID: <CAKQh6phjqskTkP5OfG3-NN9UBhWxK6UtiyZA+YcoG=x7aYS=yg__17173.7695149661$1385861105$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0790874532=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1VmvlU-0003aO-JJ
	for lttng-dev@lists.lttng.org; Sat, 30 Nov 2013 20:24:10 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so16545457pbb.17
	for <lttng-dev@lists.lttng.org>; Sat, 30 Nov 2013 17:23:58 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0790874532==
Content-Type: multipart/alternative; boundary=001a11369d70eae4c104ec6eeaff

--001a11369d70eae4c104ec6eeaff
Content-Type: text/plain; charset=ISO-8859-1

Hi Matthew:

In that case I need to create a map myself.

I  was looking for the system call ids for the following reasons:

1. In LTTng 1.0, there were several occasions when only the system call id
was found in a trace but not the names. If such is the case with LTTng 2.0,
then my concern is  that it would be better to extract ids.

2. Trained models need to be stored in database and ids will take lesser
sapce as the model grows with time.

Regards,
Shariyar



Message: 1
Date: Fri, 29 Nov 2013 10:39:54 -0500
From: Matthew Khouzam <matthew.khouzam@ericsson.com>
To: <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Extracting System Call IDs By Using TMF
Message-ID: <5298B54A.5080907@ericsson.com>
Content-Type: text/plain; charset="ISO-8859-1"

Hi Shariyar,

I would like to know what is the need for the syscall id? I looked at
kernel events, and they store the system call name, not the id? Is it
for performance reasons, or is there some functionality that can be
achieved from a call ID that cannot from a name?

--001a11369d70eae4c104ec6eeaff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Matthew:</div><div>=A0</div><div>In that case I ne=
ed to create a map myself. </div><div>=A0</div><div>I=A0 was looking for=A0=
the system call ids for the following reasons:</div><div>=A0</div><div>1. I=
n LTTng 1.0, there were=A0several occasions when only the system call id wa=
s found in a trace but not the names. If such is the=A0case with LTTng 2.0,=
 then my concern is=A0 that it would=A0be=A0better to extract ids.</div>
<div>=A0</div><div>2.=A0Trained models need to be stored=A0in database and =
ids will take lesser sapce as the model grows with time. </div><div>=A0</di=
v><div>Regards,</div><div>Shariyar</div><div>=A0</div><div>=A0</div><div>=
=A0</div><div>
Message: 1<br>Date: Fri, 29 Nov 2013 10:39:54 -0500<br>From: Matthew Khouza=
m &lt;<a href=3D"mailto:matthew.khouzam@ericsson.com"><font color=3D"#0066c=
c">matthew.khouzam@ericsson.com</font></a>&gt;<br>To: &lt;<a href=3D"mailto=
:lttng-dev@lists.lttng.org"><font color=3D"#0066cc">lttng-dev@lists.lttng.o=
rg</font></a>&gt;<br>
Subject: Re: [lttng-dev] Extracting System Call IDs By Using TMF<br>Message=
-ID: &lt;<a href=3D"mailto:5298B54A.5080907@ericsson.com"><font color=3D"#0=
066cc">5298B54A.5080907@ericsson.com</font></a><font color=3D"#0066cc"></fo=
nt>&gt;<br>
Content-Type: text/plain; charset=3D&quot;ISO-8859-1&quot;<br><br>Hi Shariy=
ar,<br><br>I would like to know what is the need for the syscall id? I look=
ed at<br>kernel events, and they store the system call name, not the id? Is=
 it<br>
for performance reasons, or is there some functionality that can be<br>achi=
eved from a call ID that cannot from a name?<br></div></div>

--001a11369d70eae4c104ec6eeaff--


--===============0790874532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0790874532==--
