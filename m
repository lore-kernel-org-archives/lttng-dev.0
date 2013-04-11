From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC lttng-tools] Triggers
Date: Thu, 11 Apr 2013 14:32:45 -0400
Message-ID: <516701CD.9060000__35381.0342996896$1365705191$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D0DFCE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UQMIh-0001x1-Sh
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 14:32:48 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D0DFCE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Or use --name as an optional option.

But indeed, the "add, del and list" command would have to be reserved
meaning no "WHAT/WHERE" would be "add".

David

Thibault, Daniel:
>> Maybe something like that ?
>> $ lttng trigger [OPTIONS] {add|list|del} <NAME> <WHAT/WHERE> <ACTION>
> =

> The problem with this is that lttng will become confused in its expectati=
ons if the <NAME> is one of "add", "list", or "del".  It'd be better to use=
 options, i.e. "--add", "--list", "--del" or "--command=3D{add|list|del}".
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
