From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: About Lttng trace mode
Date: Thu, 14 Nov 2013 17:01:25 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A22BC__29622.548147063$1384448563$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vh0IP-0007YN-Pm
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 12:01:39 -0500
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
Cc: XIANG Hao <Hao.Xiang@alcatel-sbell.com.cn>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Date: Thu, 14 Nov 2013 13:24:16 +0000
From: XIANG Hao <Hao.Xiang@alcatel-sbell.com.cn>

>   Could Lttng support transmit trace to host PC in a "live mode" or "fly =
mode" now? So as to reduce the buffer size requirement on the target board.
>
>   BTW, I read some material mentioned:
>   The discard mode is used by default. In this mode, new trace data arriv=
ing to a full buffer are discarded. In overwrite mode, the oldest trace dat=
a in the buffer are discarded.
>   This mode is also known as flight-recorder mode. Note however, that thi=
s refers to the internal buffers, not to the trace log storage. The discard=
ing of events is marked in
>   the trace log and can be noticed when the trace is analyzed. In this wa=
y the user can interactively adjust his trace settings.
>
>   What is the difference between "internal buffers" and "trace log storag=
e"? Could the trace log storage be located in the host PC?
>   For example: the target board transmit the trace to Host PC via TCP/UDP=
, and only a very little internal flight-recorder buffer is required in the=
 target device. Is it feasible?

   Live mode is nearly ready; expect it with version 2.4.

   The difference between internal buffers and trace log storage goes like =
this: the event providers write into a memory buffer (the internal buffers)=
, and at the same time the consumer daemon(s) withdraw event records from t=
he buffer and commit them to permanent storage (trace log storage).  The bu=
ffer is broken down into a number of sub-buffers, and each sub-buffer can o=
nly be accessed either by the writers (collectively) or by the consumer.  I=
n discard mode, while a sub-buffer is locked for consumer access, should th=
e writers go around the set of sub-buffers and come up behind the consumer,=
 their request to write into the consumer's sub-buffer will be denied, and =
they will then discard the event they wanted to record.  The "not to the tr=
ace log storage" bit is there to clarify that no event record may ever be l=
ost from the trace files once it has been written into them: they can neith=
er be discarded nor overwritten.  (Actually, using the enable-channel trace=
file-size and tracefile-count options, you *can* set up an on-disk flight r=
ecorder, but that is a different scenario)

   LTTng can already transmit the trace events to a host machine.  Going ba=
ck to the example of the writers writing into a memory buffer while the con=
sumer withdraws events from it, the consumer can be instructed to transmit =
the records to a TCP address instead of writing them to local file storage.=
  At that address, a relay daemon receives the records and writes them to f=
ile storage.  Example:

(on the host machine:)
$ lttng-relayd &
(on the traced machine:)
$ lttng create mysession --set-url net://host
(enable events and channels, etc.)
$ lttng start
(.)
$ lttng destroy

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
