From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: memory usage depending on number and size of
 subbuffers
Date: Wed, 16 Apr 2014 19:12:27 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599CCCD__45974.8653848239$1397675619$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WaVG5-00034Q-GX
 for lttng-dev@lists.lttng.org; Wed, 16 Apr 2014 15:12:39 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
>> Date: Wed, 16 Apr 2014 18:22:42 +0200
>> From: S?bastien Barth?l?my <barthelemy@crans.org>
>>
>> LTTng uses more memory than I expected. On the simple experiment below o=
ne can see that the "cached" memory increases by
>>
>> subbuf_size*num_cpu*(num_subbuf+1)
>>
>> That's not a big deal, but I did not expect the "+1".
>>
>> Does somebody know where it comes from?

> Date: Wed, 16 Apr 2014 17:32:39 +0000 (UTC)
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> It is the extra sub-buffer needed for reading a sub-buffer while the =

> other sub-buffers are written into. It's needed for snapshotting =

> data while tracing is active. =

>
> Mathieu =


   If I'm not mistaken, the "passing sub-buffer" is used in overwrite mode =
(as opposed to discard mode), not especially for snapshot mode.  It is in f=
act possible to run in snapshot+discard mode, although that may not be very=
 useful in most use cases.  Can you confirm, Mathieu?

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
