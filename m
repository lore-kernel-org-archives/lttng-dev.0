From: Jesper Derehag <jderehag@hotmail.com>
Subject: relayd TCP reconnect?
Date: Wed, 25 Mar 2015 15:16:32 +0000
Message-ID: <DUB123-W281E1610272EFEB7FEBDA2DD0B0__28358.7241349325$1427296667$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub004-omc3s36.hotmail.com ([157.55.2.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jderehag@hotmail.com>) id 1Yan2s-0005uF-OT
 for lttng-dev@lists.lttng.org; Wed, 25 Mar 2015 11:16:42 -0400
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

Hi All,

I know the issue with relayd reconnects have been discussed earlier here:
http://lists.lttng.org/pipermail/lttng-dev/2014-October/023650.html

But has there been any further development on this?=A0
I would actually go as far as calling it a bug and submitting it to redmine=
 tracker, but want to get approval here first.

I would argue that its *always* a good idea to do reconnects due to that yo=
u really dont have any end-to-end control of the TCP flow.=A0
Some random router might decide to spuriously drop your connection, not to =
mention more modern queuing disciplines which might randomly throw away pac=
kets.

On automated systems, that would mean that you have to somehow automagicall=
y detect that you got a disconnect, and then externally restart the session=
, which seems like a very weird workaround...

I would be happy to file such a issue to the tracker if people thinks its a=
 good idea, (and depending on if I have the time I *might* look into solvin=
g it myself).=A0
But it might be some time away in that case..

Regards,
Jesper


 		 	   		  =
