From: shirish gajera <gajerashirish@gmail.com>
Subject: Disable LTTng tracing to disk
Date: Thu, 26 Mar 2015 14:34:28 -0700
Message-ID: <CAG77vrqS-T5Nk_=qdJg629LmQTBva4Bsju3GDbkw9yPutfeZ6w__12090.2671981186$1427405734$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0108606222=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gajerashirish@gmail.com>) id 1YbFQA-0006bJ-7s
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 17:34:36 -0400
Received: by wgs2 with SMTP id 2so79294450wgs.1
 for <lttng-dev@lists.lttng.org>; Thu, 26 Mar 2015 14:34:28 -0700 (PDT)
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

--===============0108606222==
Content-Type: multipart/alternative; boundary=047d7b86d6cad48207051237c749

--047d7b86d6cad48207051237c749
Content-Type: text/plain; charset=UTF-8

Hello,

Is there any option where I can disable LTTng tracing to disk? But, I want
in memory tracing.

What I want is not to write to disk and reading the tracing from the in
memory. So, my next question will be how to read in memory tracing ?

I tried following but I am not sure whether this will disable tracing to
disk or not.

lttng create --no-output TESTING
lttng enable-channel --userspace --tracefile-size 1M --tracefile-count 1
--overwrite channel1
lttng enable-event -u -a -c channel1
lttng start

Thanks.

--047d7b86d6cad48207051237c749
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Is there any option where I can =
disable=C2=A0LTTng tracing to disk? But, I want in memory tracing.</div><di=
v><br></div><div>What I want is not to write to disk and reading the tracin=
g from the in memory. So, my next question will be how to read in memory tr=
acing ?</div><div><br></div><div>I tried following but I am not sure whethe=
r this will disable tracing to disk or not.</div><div><br></div><div><div>l=
ttng create --no-output TESTING</div><div>lttng enable-channel --userspace =
--tracefile-size 1M --tracefile-count 1 --overwrite channel1<br></div><div>=
lttng enable-event -u -a -c channel1<br></div><div>lttng start<br></div></d=
iv><div><br></div><div>Thanks.</div></div>

--047d7b86d6cad48207051237c749--


--===============0108606222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0108606222==--
