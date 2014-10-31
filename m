From: =?iso-8859-1?Q?Marc-Andr=E9_Laperle?= <marc-andre.laperle@ericsson.com>
Subject: Re: Listing live sessions after a session is destroyed
Date: Fri, 31 Oct 2014 14:47:40 +0000
Message-ID: <D381217948BF4C45AF756AFC995BEB9F1C2EE352__49513.0406613045$1414766938$gmane$org@eusaamb103.ericsson.se>
References: <D381217948BF4C45AF756AFC995BEB9F1C2EBF68@eusaamb103.ericsson.se>,
 <CA+jJMxs-gDcAqBBvwfRQA40uLjmdXZTBJCyafp+8vTN=BZZnJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <marc-andre.laperle@ericsson.com>) id 1XkDUS-0002Pg-9a
 for lttng-dev@lists.lttng.org; Fri, 31 Oct 2014 10:47:53 -0400
In-Reply-To: <CA+jJMxs-gDcAqBBvwfRQA40uLjmdXZTBJCyafp+8vTN=BZZnJA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi J=E9r=E9mie,

Thank you for your response. I am seeing this problem with a different view=
er than babeltrace that we are implementing in Trace Compass. I filled a bu=
g here:
http://bugs.lttng.org/issues/853

> What do you mean by "creating a new viewer"?

I meant opening a new connection to relayd which will create a new "viewer"=
 from relayd's perspective.

Thank you,
Marc-Andr=E9

________________________________________
From: jeremie.galarneau@gmail.com [jeremie.galarneau@gmail.com] on behalf o=
f J=E9r=E9mie Galarneau [jeremie.galarneau@efficios.com]
Sent: Thursday, 30 October 2014 2:41 PM
To: Marc-Andr=E9 Laperle
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Listing live sessions after a session is destroyed

On Wed, Oct 29, 2014 at 5:39 PM, Marc-Andr=E9 Laperle
<marc-andre.laperle@ericsson.com> wrote:
> I have a viewer connected to relayd and attached to a session named "live=
".
> The session is started then destroyed. Then I list the sessions using the
> same viewer and it returns the destroyed session. If I try to attach to i=
t,
> it returns a status LTTNG_VIEWER_ATTACH_ALREADY. I think this session sho=
uld
> not be listed or there should be a status that indicates that the session

Hi Marc-Andr=E9,

That does look like a bug. Would you mind opening a bug on
bugs.lttng.org describing the steps you take along with the babeltrace
(assuming this is the viewer you are using) and relayd verbose logs?
(launch both with -vvv)

> doesn't exist anymore. Or is it expected that I create a new viewer before
> listing the sessions again?

What do you mean by "creating a new viewer"?

Regards,
J=E9r=E9mie

>
> Thank you for the help!
> Marc-Andre
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
