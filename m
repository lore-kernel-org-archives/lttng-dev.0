From: Avi Goren <avi@reduxio.com>
Subject: Working with lttng enable-channel
Date: Mon, 24 Jun 2013 17:28:26 +0300
Message-ID: <CA+f7N8nXaViFf9UKRU9vFttcyjnVqQ38Np56pa1+dj=V7jAvxA__19781.7573011436$1372089967$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0054872830=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <avi@reduxio.com>) id 1Ur7ku-0004p0-KU
	for lttng-dev@lists.lttng.org; Mon, 24 Jun 2013 10:28:32 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so8167673vbb.23
	for <lttng-dev@lists.lttng.org>; Mon, 24 Jun 2013 07:28:27 -0700 (PDT)
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

--===============0054872830==
Content-Type: multipart/alternative; boundary=089e013a0624cabf3604dfe7397a

--089e013a0624cabf3604dfe7397a
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I'm using lttng-ust and in the process of the attempt to gain some flush
frequency control I encountered a problem.
I'm having difficulties with the use of enable-channel.
it doesn't seem to apply property changes. here's an example:
-------------------------------------------------------------------------
root@ubuntu:~# lttng list
Currently no available tracing session
root@ubuntu:~# lttng create ses
Session ses created.
Traces will be written in /home/avig/lttng-traces/ses-20130624-163340
root@ubuntu:~# lttng enable-event -a -u -s ses -c ch
All UST events are enabled in channel ch
root@ubuntu:~# lttng disable-channel ch -u -s ses
UST channel ch disabled for session ses
root@ubuntu:~# lttng enable-channel ch -u --subbuf-size 1024 --num-subbuf 1
UST channel ch enabled for session ses
root@ubuntu:~# lttng list ses -c ch
Tracing session ses: [inactive]
    Trace path: /home/avig/lttng-traces/ses-20130624-163340

=== Domain: UST global ===

Buffer type: per PID

- ch: [enabled]

    Attributes:
      write mode: discard
      subbufers size: 4096 bytes
      number of subbufers: 4
      switch timer interval: 0 usec
      read timer interval: 0 usec
      output: mmap()

    Events:
      * (type: tracepoint) [enabled]

root@ubuntu:~# lttng version
lttng version 2.2.0-rc2 - Cuda
...
-------------------------------------------------------------------------

Am I doing something wrong?
Is there a way to control flushing policy besides the use of enable-channel?
Thanks,
Avi

--089e013a0624cabf3604dfe7397a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I&#39;m using lttng-ust and in the proc=
ess of the attempt to gain some flush</div><div>frequency control I encount=
ered a problem.</div><div>I&#39;m having difficulties with the use of enabl=
e-channel.</div>
<div>it doesn&#39;t seem to apply property changes. here&#39;s an example:<=
/div><div>-----------------------------------------------------------------=
--------</div><div>root@ubuntu:~# lttng list</div><div>Currently no availab=
le tracing session</div>
<div>root@ubuntu:~# lttng create ses</div><div>Session ses created.</div><d=
iv>Traces will be written in /home/avig/lttng-traces/ses-20130624-163340</d=
iv><div>root@ubuntu:~# lttng enable-event -a -u -s ses -c ch</div><div>
All UST events are enabled in channel ch</div><div>root@ubuntu:~# lttng dis=
able-channel ch -u -s ses</div><div>UST channel ch disabled for session ses=
</div><div>root@ubuntu:~# lttng enable-channel ch -u --subbuf-size 1024 --n=
um-subbuf 1</div>
<div>UST channel ch enabled for session ses</div><div>root@ubuntu:~# lttng =
list ses -c ch</div><div>Tracing session ses: [inactive]</div><div>=A0 =A0 =
Trace path: /home/avig/lttng-traces/ses-20130624-163340</div><div><br></div=
>
<div>=3D=3D=3D Domain: UST global =3D=3D=3D</div><div><br></div><div>Buffer=
 type: per PID</div><div><br></div><div>- ch: [enabled]</div><div><br></div=
><div>=A0 =A0 Attributes:</div><div>=A0 =A0 =A0 write mode: discard</div><d=
iv>=A0 =A0 =A0 subbufers size: 4096 bytes</div>
<div>=A0 =A0 =A0 number of subbufers: 4</div><div>=A0 =A0 =A0 switch timer =
interval: 0 usec</div><div>=A0 =A0 =A0 read timer interval: 0 usec</div><di=
v>=A0 =A0 =A0 output: mmap()</div><div><br></div><div>=A0 =A0 Events:</div>=
<div>=A0 =A0 =A0 * (type: tracepoint) [enabled]</div>
<div><br></div><div>root@ubuntu:~# lttng version=A0</div><div>lttng version=
 2.2.0-rc2 - Cuda</div><div>...</div><div>---------------------------------=
----------------------------------------</div><div><br></div><div>Am I doin=
g something wrong?</div>
<div>Is there a way to control flushing policy besides the use of enable-ch=
annel?</div><div>Thanks,</div><div>Avi</div></div>

--089e013a0624cabf3604dfe7397a--


--===============0054872830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0054872830==--
