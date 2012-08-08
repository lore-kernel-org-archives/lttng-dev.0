From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC] LTTng address API proposal v3
Date: Wed, 08 Aug 2012 13:17:21 -0400
Message-ID: <50229F21.4080400__12932.1586261087$1344446277$gmane$org@efficios.com>
References: <502167DF.5000806@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Sz9sq-0001TB-Rl
	for lttng-dev@lists.lttng.org; Wed, 08 Aug 2012 13:17:24 -0400
In-Reply-To: <502167DF.5000806@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ADDENDUM:

The set_consumer_url() call needs an extra arguments since we can both
set the CONTROL or STREAM path using this call (the stream type).

So, I would like to propose a change:

From:
lttng_set_consumer_url(struct lttng_handle *handle, const char *url);

To:
lttng_set_consumer_url(struct lttng_handle *handle, const char *url,
			enum lttng_url_stream_type stype);

With:
enum lttng_url_stream_type {
	LTTNG_STREAM_CONTROL,
	LTTNG_STREAM_DATA,
	LTTNG_STREAM_ALL,
};

An _url_ argument with "net://localhost" for instance implies
LTTNG_STREAM_ALL as a type however with "tcp://", we have to specify it.

The second possible idea is to add specialize calls like:

set_consumer_control_url()
set_consumer_stream_url()

Though?

Cheers!
David

David Goulet:
> After a discussion with Mathieu and Yannick, here is some big
> changes.
> 
> I hope I did not forget anything important.
> 
> Cheers! David
> 
> 
> 
> This body part will be downloaded on demand.
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQIp8aAAoJEELoaioR9I02cBYIAJYI9cFpWwTUq7kAImWB/ZAZ
20NLdDhjvYkHkLdHs76++P5d5DowHYZBY4dFrUKDlRTA5INQ/Q3OeZMCiCs9HkDM
i4JZCJdIrgI6Y1Wu5aVKU3kjN11z+169qAx4YYarKoXsordWcPzsBfPazRsJNfVy
zAhcY0LQFOgxRDnxAg7zxVIQFimYS/OZBM976fRCRxwV6YBNscEQj9OYgBq8nCOm
76vR1p5WPb93jX/wqe2/ilHAhRslVWedn0p+OT1kNWW0puPyWf2NHxY/KqqhkhAy
yFkMeVXJtvnGig1UPgm7H7eouCRAAM04aS6qCVfZz9vBJALEk42UVbcLPO6GzQg=
=VobI
-----END PGP SIGNATURE-----
