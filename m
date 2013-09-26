From: Julien Desfossez <julien.desfossez@polymtl.ca>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 15:03:33 -0400
Message-ID: <52448505.10205__12779.7887697399$1380222279$gmane$org@polymtl.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793984@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <julien.desfossez@polymtl.ca>) id 1VPGqh-0003o4-LD
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 15:03:45 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26793984@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



On 13-09-26 02:20 PM, Thibault, Daniel wrote:
> Date: Thu, 26 Sep 2013 12:16:29 -0400
> From: Julien Desfossez <jdesfossez@efficios.com>
> =

>> When the consumer needs to read a subbuffer, it performs a get_subbuf op=
eration. If this operation succeeds, =

>> the consumer has exclusive access to this subbuffer and so it can read i=
t safely. If it fails, it means the tracer is =

>> currently using it and in the case of snapshots, the consumer will just =
skip to the next one (up to the end =

>> position it defined at the beginning of the snapshot).
>>
>> Julien
> =

>    Presumably the tracers also use get_subbuf, so what happens if they ar=
e refused access because the consumer =

> got the sub-buffer first?  Do they wait for the consumer to relinquish th=
e sub-buffer, or do they skip ahead?
They skip ahead.

Julien

> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
