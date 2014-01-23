From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Trace-file size and flight record mode
Date: Thu, 23 Jan 2014 14:33:02 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267DC026__41731.9645792761$1390487650$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1W6LLA-0005to-8p
	for lttng-dev@lists.lttng.org; Thu, 23 Jan 2014 09:33:14 -0500
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
Cc: Anand Neeli <anand.neeli@gmail.com>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Date: Thu, 23 Jan 2014 14:06:03 +0530
From: Anand Neeli <anand.neeli@gmail.com>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>

> can anyone help me with these queries. These are related to trace modes a=
nd file sizes.
> I use the following commands to trace
>    ./lttng enable-channel mychannel --userspace --buffers-pid -s mysession
>    ./lttng enable-event --channel mychannel --userspace --all -s mysession
>
> here are my queries
> 1) Trace file should be limited to some defined size and should be overwr=
itten after it reaches max size.
> I want to retain latest N bytes of traces.
> can anyone pls provide more details and the command to enable this?

lttng enable-channel mychannel -u --buffers-pid -s mysession --tracefile-si=
ze N --tracefile-count 1

This will limit each mychannel_n file to N bytes.  If running on multiple C=
PUs, you get multiple mychannel_n files, each limited to N bytes.  And each=
 process ID will have its trace file limited separately.  Further, you won'=
t capture "the last N bytes of events"; rather, every time the file is fill=
ed, it gets wiped and a new set of event records begins being captured.  If=
 you were to use say --tracefile-size M --tracefile-count 8 (where M is N/8=
), you would guarantee keeping at least 7M bytes' worth of events in the tr=
ace.

> I see -C and -W options. But will the files be overwritten to maintain la=
test traces?
> and if i use "-W 4" will it create 4xN bytes of latest traces?

   Yes, -W 4 creates 4 files of size -C N each.  LTTng would write file 1, =
file 2, file 3, file 4, then overwrite file 1, then file 2, etc.

   Note that when you babeltrace this, you will get what seems to be spurio=
us "discarded events" warnings.  This may be a bug (using LTTng 2.3.0).

> 2) Flight recorder mode
> If i'm not wrong "Flight recorder mode" continuously overwrite the data i=
n the memory buffers, instead of flushing it to a file on disk.
> How to flush this memory buffer to file to see the traces or is there a w=
ay to read this memory?

   If by "flight recorder mode" you mean 'lttng create --snapshot', you use=
 the 'lttng snapshot record' command to take the snapshots (copy the buffer=
s to trace files).  See the man pages.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
