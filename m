From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: calibrate ?
Date: Wed, 13 Feb 2013 21:23:43 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD016445__10253.6103608601$1360790716$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1U5joY-0002ug-6f
	for lttng-dev@lists.lttng.org; Wed, 13 Feb 2013 16:24:26 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

I took note of http://lwn.net/Articles/492296/ (Mathieu Desnoyers, Julien D=
esfossez, David Goulet; LTTng 2.0: Tracing for power users and developers -=
 part 2, April 18, 2012) and ran this (using the Ubuntu lttng packages this=
 time; babeltrace is 1.0.0~rc1-0ubuntu1 and lttng is 2.0.1-0ubuntu1 [libltt=
ng-ctl0, lttng-tools] and 2.0.2-0ubuntu1 [liblttng-ust0, lttng-modules-dkms=
]):

$ sudo -H lttng create calibrate-session
Session calibrate-session created.
Traces will be written in /root/lttng-traces/calibrate-session-20130213-143=
220
$ sudo -H lttng enable-event calibrate-event -k --function lttng_calibrate_=
kretprobe
kernel event calibrate-event created in channel channel0
$ sudo -H lttng add-context -k -t perf:LLC-load-misses -t perf:LLC-store-mi=
sses -t perf:LLC-prefetch-misses
Error: perf:LLC-prefetch-misses: Add kernel context failed
kernel context perf:LLC-store-misses added to all channels
kernel context perf:LLC-load-misses added to all channels
Warning: Some command(s) went wrong
$ sudo -H lttng start
Tracing started for session calibrate-session
$ for a in $(seq 1 10); do \
> sudo -H lttng calibrate -k --function; \
> done
Kernel calibration done
Kernel calibration done
Kernel calibration done
Kernel calibration done
Kernel calibration done
Kernel calibration done
Kernel calibration done
Kernel calibration done
Kernel calibration done
Kernel calibration done
$ sudo -H lttng destroy
Session calibrate-session destroyed at /root
$ sudo -H babeltrace /root/lttng-traces/calibrate-session-20130213-143220
error syntax error
[error] Error creating AST
[warning] Unable to open trace metadata for path "/root/lttng-traces/calibr=
ate-session-20130213-143220/kernel".
[warning] [Context] Cannot open_trace of the format /root/lttng-traces/cali=
brate-session-20130213-143220/kernel .

[warning] [Context] opening trace "/root/lttng-traces/calibrate-session-201=
30213-143220/kernel" from /root/lttng-traces/calibrate-session-20130213-143=
220 for reading.

##########
Now, the "Error: perf:LLC-prefetch-misses: Add kernel context failed" is pr=
obably because 'dmesg | grep "generic r"' reports just two generic register=
s, although it seems odd the error would occur on the first context attempt=
 and not the last.

My real problem is with the trace thus generated and babeltrace's handling =
of it.  It consists of five files: metadata and channel0_0 through channel0=
_3.  There is no kernel file.

I moved the trace to another machine and tried a more up-to-date babeltrace=
 (babeltrace-1.0.3+-217b52c), with little difference:

error syntax error
[error] Error creating AST
[warning] Unable to open trace metadata for path "/home/daniel/lttng-traces=
/calibrate-session-20130213-143220/kernel".
[warning] [Context] Cannot open_trace of format ctf at path /home/daniel/lt=
tng-traces/calibrate-session-20130213-143220/kernel.

[warning] [Context] cannot open trace "/home/daniel/lttng-traces/calibrate-=
session-20130213-143220/kernel" from /home/daniel/lttng-traces/calibrate-se=
ssion-20130213-143220 for reading.
[error] Cannot open any trace for reading.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
