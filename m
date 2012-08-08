From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [RFC] LTTng address API proposal v3
Date: Wed, 08 Aug 2012 16:42:41 -0400
Message-ID: <5022CF41.9030605__32709.3413834975$1344458601$gmane$org@gmail.com>
References: <502167DF.5000806@efficios.com> <50229F21.4080400@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f48.google.com ([209.85.213.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SzD5h-00030n-4F
	for lttng-dev@lists.lttng.org; Wed, 08 Aug 2012 16:42:53 -0400
Received: by yhfq46 with SMTP id q46so1491771yhf.35
	for <lttng-dev@lists.lttng.org>; Wed, 08 Aug 2012 13:42:43 -0700 (PDT)
In-Reply-To: <50229F21.4080400@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2012-08-08 13:17, David Goulet wrote:
> ADDENDUM:
>
> The set_consumer_url() call needs an extra arguments since we can both
> set the CONTROL or STREAM path using this call (the stream type).
>
> So, I would like to propose a change:
>
> From:
> lttng_set_consumer_url(struct lttng_handle *handle, const char *url);
>
> To:
> lttng_set_consumer_url(struct lttng_handle *handle, const char *url,
> enum lttng_url_stream_type stype);
>
> With:
> enum lttng_url_stream_type {
> LTTNG_STREAM_CONTROL,
> LTTNG_STREAM_DATA,
> LTTNG_STREAM_ALL,
> };
>
> An _url_ argument with "net://localhost" for instance implies
> LTTNG_STREAM_ALL as a type however with "tcp://", we have to specify it.
>
> The second possible idea is to add specialize calls like:
>
> set_consumer_control_url()
> set_consumer_stream_url()

Just brainstorming:
lttng_set_consumer_url(struct lttng_handle *handle, const char
*control_url, const char *data_url)

Yannick
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAiz0AACgkQFQrZ7GzHX2qd/ACg4uX+tLdSIuBNIz9LvT+6Gy7R
O+oAoMevaOacHiR2VI8LA18eeAB0jnCD
=iRYC
-----END PGP SIGNATURE-----
