From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/5] bash completion: Remove
 --event for add-context
Date: Wed, 07 Aug 2013 05:47:37 -0400
Message-ID: <520217B9.5080703__31183.184302836$1375868920$gmane$org@efficios.com>
References: <1375125765-16063-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1V70LK-00044F-0M
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 05:47:49 -0400
In-Reply-To: <1375125765-16063-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: simon.marchi@polymtl.ca
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Merged. Thanks!

simon.marchi@polymtl.ca:
> From: Simon Marchi <simon.marchi@polymtl.ca>
> 
> --event has been remove in
> 601d5acf42ebdb05ff8aa19f12fd9bdad3602781.
> 
> Reported-by: Daniel U. Thibault <daniel.thibault@drdc-rddc.gc.ca> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca> --- 
> extras/lttng-bash_completion |    3 --- 1 files changed, 0
> insertions(+), 3 deletions(-)
> 
> diff --git a/extras/lttng-bash_completion
> b/extras/lttng-bash_completion index b515be0..efd5f58 100644 ---
> a/extras/lttng-bash_completion +++ b/extras/lttng-bash_completion 
> @@ -32,9 +32,6 @@ _lttng_cmd_add_context() { --channel|-c) return 
> ;; -	--event|-e) -		return -		;; --type|-t) return ;;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBCgAGBQJSAhe2AAoJEELoaioR9I02Tv8H/1Zh88eaot2/WFOe0tUhR41o
dMu4Nd7yETzxXM71phCMk8lqe9eMsyWQ0qHwYkuP5w2r6qW9NTbjEiQU2diLzM5Y
hz/fh4/C0juh7feVn+8wHFSqjUiZZnQzGAQpXhsILbgF9gKvDAgpqlTL5a8B6yL3
2h2Icy7p8yezumgt/tYjoczK5KNfqt4tpx70CErp6VRvh5ZDPMMvUINITrX8wVP0
EcX1Dk5B5zaH7ud6er1kGSskPPVEpIZiMunRru4OjbUSdHq4i1Tj5uYLv68V/b7h
bLs/Fnme8UTWUQclARXazohz9lWSoid3mVqyXM+pJzkI1Kao1PfBpm6fe+0SioE=
=Yhg4
-----END PGP SIGNATURE-----
