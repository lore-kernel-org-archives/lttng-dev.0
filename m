From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: About Lttng trace mode
Date: Tue, 4 Feb 2014 15:24:41 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267DE171__39035.2922761396$1391527563$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WAhrv-0007Mh-5P
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 10:25:05 -0500
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
List-Id: lttng-dev@lists.lttng.org

Date: Mon, 3 Feb 2014 16:03:14 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

>----- Original Message -----
>> From: "Daniel Thibault" <Daniel.Thibault@drdc-rddc.gc.ca>
>> Sent: Thursday, November 14, 2013 12:01:25 PM
>> =

>>  [...]
>>    or by the consumer.  In discard mode, while a sub-buffer is locked for
>>    consumer access, should the writers go around the set of sub-buffers =
and
>>  [...]
>
>The paragraph above is true, except for the part "while a sub-buffer is lo=
cked for consumer access". In discard mode, as soon as the writer is fillin=
g up all sub-buffers, and thus the >produced sub-buffers count reaches the =
consumed sub-buffer count minus the number of sub-buffers in the buffer (th=
is is a buffer full situation), events are discarded. This is done >indepen=
dently of whether or not the consumer is currently locking a sub-buffer for=
 reading.

   Good, subtle point.  The sub-buffer is marked for consumption ("read-rea=
dy"), just not actively locked ("being read").

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
