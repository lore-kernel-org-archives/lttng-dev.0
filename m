From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] Move metset in channel_set_attr
 after the null check
Date: Thu, 07 Jun 2012 13:05:36 -0400
Message-ID: <4FD0DF60.2080709__35469.694241374$1339088769$gmane$org@efficios.com>
References: <1339008870-4891-1-git-send-email-serres@live.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Scg9U-000828-8y
	for lttng-dev@lists.lttng.org; Thu, 07 Jun 2012 13:05:40 -0400
In-Reply-To: <1339008870-4891-1-git-send-email-serres@live.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <serres@live.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Danny,

I've merged your patch. Thanks! It's now upstream and in stable-2.0 :).

Just a note for the next time. This is a "Fix" patch so in the commit message,
start with "Fix:". I've changed it for you for this commit. Only commit with
Fix: are picked for the stable-2.0 branch.

commit eacaa7a62c3f2b9a019fd145d69c977fc53144bb
Author: Danny Serres <danny.serres@efficios.com>
Date:   Wed Jun 6 14:54:30 2012 -0400

    Fix: move memset in channel_set_attr after NULL check

    Signed-off-by: Danny Serres <danny.serres@efficios.com>
    Signed-off-by: David Goulet <dgoulet@efficios.com>


Cheers!
David

On 06/06/12 02:54 PM, Danny Serres wrote:
> Signed-off-by: Danny Serres <serres@live.ca> --- 
> src/lib/lttng-ctl/lttng-ctl.c |    4 ++-- 1 file changed, 2 insertions(+),
> 2 deletions(-)
> 
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c 
> index 36069ef..356fb34 100644 --- a/src/lib/lttng-ctl/lttng-ctl.c +++
> b/src/lib/lttng-ctl/lttng-ctl.c @@ -885,13 +885,13 @@ int
> lttng_calibrate(struct lttng_handle *handle, void
> lttng_channel_set_default_attr(struct lttng_domain *domain, struct
> lttng_channel_attr *attr) { -	memset(attr, 0, sizeof(struct
> lttng_channel_attr)); - /* Safety check */ if (attr == NULL || domain ==
> NULL) { return; }
> 
> +	memset(attr, 0, sizeof(struct lttng_channel_attr)); + switch
> (domain->type) { case LTTNG_DOMAIN_KERNEL: attr->overwrite =
> DEFAULT_CHANNEL_OVERWRITE;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJP0N9dAAoJEELoaioR9I02N3gH/3y9buoeohXbFW3YgF+ACTov
Tzon+vqwglgYDBd6xCtxzNUxvMR/UdTeuOr8V6RYTApHEXzgM3viLlpLFjB5YR01
qHBCl5mpp7hRHE/VAWIS4wJfg1lBeR+m+dAg+FB0SZKxm/3FiLzkltI3IQlmi6zH
qpNPXYfpEPm5Z6TmW0S+4P8qryVSkXO8OmM16NydXq3w6TOPmVkaqgYemNs2brAR
pmcw9ab9OMxqhZwL3ZG39SbMxstqhZy6qlMo6OM87uoVzVh52OUFspkemmk7O2vv
2/RZVp+5b0NgA5I1QwAXB3uU6AXv+Ld+dbSg9KosppvfFAQWieCMcaElnORt63M=
=LClK
-----END PGP SIGNATURE-----
