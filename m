From: Jeffrey Chen <cpthk@live.com>
Subject: How to use the log rotation correctly?
Date: Tue, 1 Mar 2016 23:12:42 +0000
Message-ID: <CY1PR13MB0778E22DB0AE961A8E37894CC7BB0__13496.5355544866$1456874038$gmane$org@CY1PR13MB0778.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0512633658=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from snt004-omc2s6.hotmail.com ([65.55.90.81])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@live.com>) id 1aatTH-0005kF-2L
 for lttng-dev@lists.lttng.org; Tue, 01 Mar 2016 18:12:53 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0512633658==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR13MB0778E22DB0AE961A8E37894CC7BB0CY1PR13MB0778namp_"

--_000_CY1PR13MB0778E22DB0AE961A8E37894CC7BB0CY1PR13MB0778namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi LTTng community:


LTTng supports trace rotation by having flags "--tracefile-size", "--tracef=
ile-count".  What is the correct use case on using the rotation files?

What we want to do is, without stopping the session, and collect the comple=
ted traces (reached file max size), and output the traces using babeltrace =
in a loop.


While I am trying to implement this, I have noticed that LTTng sometimes wo=
uld not write the metadata file (file size 0), even the trace files are bei=
ng rotated off. Without the metadata file, babeltrace would not function. I=
 am wondering whether I am using the trace rotation in the correct way. Is =
there a way to make sure that when a trace file is being rotated off, metad=
ata is also flush?


I have done some studies on the metadata file. It looks like LTTng is using=
 the stream based metadata file, which would write a packet header for each=
 packet. I noticed some events definitions will be cut off in the middle, t=
he first half at the previous packet, and second half at the next packet. D=
o we know when LTTng writes metadata, would it always write the complete ev=
ents definitions? (i.e. first half and second half of the event definition =
are BOTH in the metadata file) Would it be possible that LTTng only write t=
he first half of the definition, and second half will be written in the nex=
t cycle of the flush. I ask this because, when we collect the traces, the s=
ession is still running, and I need to confirm metadata file is in the read=
-able state.


Thanks.

--_000_CY1PR13MB0778E22DB0AE961A8E37894CC7BB0CY1PR13MB0778namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi LTTng community:</p>
<p><br>
</p>
<p>LTTng supports trace rotation by having flags &quot;--tracefile-size&quo=
t;, &quot;--tracefile-count&quot;.&nbsp; What is the correct use case on us=
ing the rotation files?</p>
<p>What we want to do is, without stopping the session, and collect the com=
pleted traces (reached file max size), and output the traces using babeltra=
ce in a loop.</p>
<p><br>
</p>
<p>While I am trying to implement this, I have noticed that LTTng sometimes=
 would not write the metadata file (file size 0), even the trace files are =
being rotated off. Without the metadata file, babeltrace would not function=
. I am wondering whether I am using
 the trace rotation in the correct way. Is there a way to make sure that wh=
en a trace file is being rotated off, metadata is also flush?</p>
<p><br>
</p>
<p>I have done some studies on the metadata file. It looks like LTTng is us=
ing the stream based metadata file, which would write a packet header for e=
ach packet. I noticed some events definitions will be cut off in the middle=
, the first half at the previous
 packet, and second half at the next packet. Do we know when LTTng writes m=
etadata, would it always write the complete events definitions? (i.e. first=
 half and second half of the event definition are BOTH in the metadata file=
) Would it be possible that LTTng
 only write the first half of the definition, and second half will be writt=
en in the next cycle of the flush. I ask this because, when we collect the =
traces, the session is still running, and I need to confirm metadata file i=
s in the read-able state.</p>
<p><br>
</p>
<p>Thanks.<br>
</p>
</div>
</body>
</html>

--_000_CY1PR13MB0778E22DB0AE961A8E37894CC7BB0CY1PR13MB0778namp_--


--===============0512633658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0512633658==--
