From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [RFC] LTTng address API proposal
Date: Thu, 02 Aug 2012 13:57:19 -0400
Message-ID: <501ABF7F.7000603__35818.2674892761$1343930271$gmane$org@polymtl.ca>
References: <50180418.5020904@polymtl.ca> <501A7CFA.8000005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SwzeF-0004Jn-9Y
	for lttng-dev@lists.lttng.org; Thu, 02 Aug 2012 13:57:23 -0400
In-Reply-To: <501A7CFA.8000005@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 02/08/12 09:13 AM, Yannick Brosseau wrote:
> 
> On 2012-07-31 12:13, David Goulet wrote:
>> This follows the discussion on IRC #lttng which aims at removing the
> lttng_uri
>> structure from the public API.
> 
>> Cheers! David
> 
>> --> lttng_create_session_addr(const char *name, const char *addr,
> 
> Why not lttng_create_session_url ?

No idea lol... you prefer that, I'm not against.

> 
>> PROTO://[HOST|IP][:PORT][/PATH]
> 
>> Examples:
> 
>> * net://myhostname * net://myhostname:9888 * net://myhostname/foo/bar *
>> net://X.X.X.X:9888/foo/bar
> 
> 
> You should put the list of protocol available. Now it seems that we cannot
> do file://

The protocols are listed in doc/proposals/0003-network.consumer.txt. However,
I might move them in that one so we can clearly define the URL string format.

> 
> 
>> lttng_set_consumer_addr(struct lttng_handle *handle,
> const char *addr);
> 
> 
> Can we have examples for the set_consumer addr ?

Ofc.

David

> 
> 
> 
>> _______________________________________________ lttng-dev mailing list 
>> lttng-dev@lists.lttng.org 
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> 
> 
> 
> 
> _______________________________________________ lttng-dev mailing list 
> lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQGr9/AAoJEELoaioR9I02NSQH/iaf4/+vBwxkkW6+KuZiRW2o
p/KkZssf1yWQPtxyspxr2JAueykKCH+PtIiB2s2QLDxWCYqOt7gSPI2XlTjdem4I
e+N6h25zVpKvlV+rzW6Aw/sbNXRyX9Pw9ldkHYxIkNJjx67Y2ZnBGa9lxdAx7t/U
LE+RMrzy9+lwdodZhx5MVJxs1JyVNmU+i+dbIsQlAPdNwUWTebxKP3JVwHz/OwwH
46++EnyFLPIeqvvVPCGJFOaBkBimMCDl0BFm+yviVWZXQKnYl44mnI41RFWa+JVF
t1BLqkxExM7FzvnXuxUbBgbhRlRLlrXhRBFlNLK9kVSpPBBm49Y0g94tsB+hEjY=
=t6Xs
-----END PGP SIGNATURE-----
