From: Divya Vyas <dvyas@mvista.com>
Subject: kvm_entry dynamic probes
Date: Mon, 2 Jun 2014 14:59:38 +0530
Message-ID: <CA+=dQ-_v7N4DwNmaEFuLMZQ2pdQAYtdvLEDpwk8mZ5pHTy-PPw__37214.6194022664$1401701458$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1013600425=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dvyas@mvista.com>) id 1WrOZA-00061F-Gb
 for lttng-dev@lists.lttng.org; Mon, 02 Jun 2014 05:30:05 -0400
Received: by mail-qa0-f52.google.com with SMTP id cm18so2377487qab.11
 for <lttng-dev@lists.lttng.org>; Mon, 02 Jun 2014 02:29:59 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1013600425==
Content-Type: multipart/alternative; boundary=001a11c11708f68e8104fad70956

--001a11c11708f68e8104fad70956
Content-Type: text/plain; charset=UTF-8

Hi,

I am getting this error while adding dynamic probe to kvm_entry

Command to change state of events failed
Command failed! Command:  lttng enable-event entry -k  -s probes --function
kvm_entry
Return Value: 4
Error: Event entry: Enable kernel event failed (channel channel0, session
probes)
Warning: Some command(s) went wrong

while same I did for kvm_exit and it works . I am using lttng 2.3.1


I got these kind of errors earlier also like for skb_kfree I got same error
while when I  created new session and tries again it succeeds .  Please let
me know why I get these kind of error.

--001a11c11708f68e8104fad70956
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I am getting this error wh=
ile adding dynamic probe to kvm_entry <br><br>Command to change state of ev=
ents failed<br>Command failed! Command:=C2=A0 lttng enable-event entry -k=
=C2=A0 -s probes --function kvm_entry<br>

Return Value: 4<br>Error: Event entry: Enable kernel event failed (channel =
channel0, session probes)<br>Warning: Some command(s) went wrong<br><br></d=
iv>while same I did for kvm_exit and it works . I am using lttng 2.3.1<br>

<br><br></div><div>I got these kind of errors earlier also like for skb_kfr=
ee I got same error while when I=C2=A0 created new session and tries again =
it succeeds .=C2=A0 Please let me know why I get these kind of error.<br><b=
r></div>

</div>

--001a11c11708f68e8104fad70956--


--===============1013600425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1013600425==--
