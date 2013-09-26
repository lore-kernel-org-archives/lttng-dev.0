From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 20:06:48 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26793A55__36276.8011437312$1380226068$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793929@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<52445DDD.9050808@efficios.com>
	<48CF5AC71E61DB46B70D0F388054EFFD2679396E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<52447DEF.5030005@efficios.com>
	<48CF5AC71E61DB46B70D0F388054EFFD267939F7@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<524490F6.5080604@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VPHpp-0007JJ-MG
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 16:06:55 -0400
In-Reply-To: <524490F6.5080604@efficios.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Envoy=E9=A0: 26 septembre 2013 15:55

>>    If the tracers pass the consumer, and then the consumer passes the =

>> tracers, does the consumer stop copying the buffer contents to the snaps=
hot trace?
>>
>> * consumer reads a number of "pass n" sub-buffers (where n is the number=
 of times the tracers have gone around)
>> * tracers catch up with the consumer, skip ahead, write at least one who=
le "pass n+1" sub-buffer
>> * tracers then stop or slow down
>> * consumer reads the "pass n+1" sub-buffer(s), then overtakes the tracers
>> * consumer skips over the sub-buffer where the tracers are, finds a "pas=
s n" sub-buffer
>> =

>>    If the consumer doesn't close the trace at that point, it would corru=
pt the snapshot.
>
> The consumer reads absolute positions in the ring-buffer, if a subbuffer =
has been overwritten, it skips to the next until it reaches its end positio=
n.
> The consumer will never read data that has been recorded after it started=
 taking the snapshot.
> That is why it is important to know that we deal with absolute positions.
>
> Is that clearer ?
>
> If you want to take a look, the code for the kernel is in the function lt=
tng_kconsumer_snapshot_channel in src/common/kernel-consumer/kernel-consume=
r.c.
> You will see that we take the begin and end positions, and then iterate s=
ubbuffer by subbuffer, if a get_subbuff(absolute_position) fails it means i=
t has already been reused and we > skip to the next.
>
> Julien

   I think I get it now: the consumer skips the "pass n+1" sub-buffers and =
reads only the "pass n" sub-buffers it encounters during its sweep.  Thanks!

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
