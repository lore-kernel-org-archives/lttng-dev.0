From: "Sadon, Mirit" <Mirit.Sadon@emc.com>
Subject: Re: clarification on limiting the size of the trace file
Date: Wed, 7 May 2014 05:12:29 +0000
Message-ID: <25901CD29106E944B1047FED2EADF345085836E8__39604.7058901333$1399440187$gmane$org@MX107CL01.corp.emc.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD3599ED94@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailuogwdur.emc.com ([128.221.224.79])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Mirit.Sadon@emc.com>) id 1WhuA5-0002kw-9O
 for lttng-dev@lists.lttng.org; Wed, 07 May 2014 01:13:04 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3599ED94@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Eshel, Ayelet" <Ayelet.Eshel@emc.com>, "Mirsky,
 Ilya" <Ilya.Mirsky@emc.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

This is what I understood should happen but in the actual run the lttng fil=
e fills all the free space in the partition 4GB.

Thanks
Mirit Sadon =


-----Original Message-----
From: Thibault, Daniel [mailto:Daniel.Thibault@drdc-rddc.gc.ca] =

Sent: Monday, May 05, 2014 7:10 PM
To: lttng-dev@lists.lttng.org
Cc: Sadon, Mirit; Eshel, Ayelet
Subject: RE: [lttng-dev] clarification on limiting the size of the trace fi=
le

----------------------------------------------------------------------
Date: Mon, 5 May 2014 08:24:39 +0000
From: "Sadon, Mirit" <Mirit.Sadon@emc.com>
Cc: "Eshel, Ayelet" <Ayelet.Eshel@emc.com>

> I am working with the lttng trace to see how it affects are program =

> performance, But if I don't limit the size of the trace file collected it=
 fills all the space in the partition I specify.
> What does it mean if I start the trace and limit the trace file to let sa=
y 1GB.
> Would the trace stop after it reaches the limit or it will continue and o=
verride the previous collected points?
>
> I tried by using this command when creating the channel but it didn't wor=
k.
>
> lttng enable-channel perf --subbuf-size 262144 -C 262144 -W 32 =

> --num-subbuf 32 -u
>
> We are working with lttng version 2.04.
>
> Mirit Sadon
> EMC2

   This feature may not have been mature with version 2.0.4; I would recomm=
end upgrading to at least 2.3 if not 2.4.

   Your command sets up a single user-space channel named perf which uses a=
 32-part buffer of total size 32*262144=3D8388608 (8 MiB).  The trace is it=
self limited to 32 chunks of size 262144 each.  By default, user-space chan=
nels run in discard mode.  So in this case LTTng should capture about 8 MiB=
 of events to disc, and a further 8 MiB in memory before "giving up" altoge=
ther.

   When the trace is started the 8 MiB buffer will start filling up, and th=
e consumer daemon will start dumping the events to the trace file.  Once th=
e trace file saturates at 8 MiB total size, the consumer daemon will stop e=
mptying the buffer.  The buffer will then capture another 8 MiB of events. =
 Once the buffer is full, LTTng will systematically discard new events as t=
hey occur.

   It would be an interesting feature if the snapshot command could be used=
 at this point to dump the 8 MiB of otherwise-lost events to another trace =
file.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC) Cyber s=E9curit=E9 pour les missions essentielles (CME) =
| Mission Critical Cyber Security (MCCS) R & D pour la d=E9fense Canada - V=
alcartier (RDDC Valcartier) | Defence R&D Canada - Valcartier (DRDC Valcart=
ier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
