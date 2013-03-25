From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add optional Perl dependency
 requirement to README
Date: Mon, 25 Mar 2013 10:32:18 -0400
Message-ID: <51505FF2.7030008__48487.7041810707$1364221994$gmane$org@efficios.com>
References: <1363981759-4718-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UK8Rh-0007V7-6C
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 10:32:21 -0400
In-Reply-To: <1363981759-4718-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Thanks

Christian Babeux:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  README | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/README b/README
> index 4ef88cb..cfbf1ac 100644
> --- a/README
> +++ b/README
> @@ -28,6 +28,9 @@ REQUIREMENTS:
>  
>        * Debian/Ubuntu package: libpopt-dev
>  
> +    - Perl (optional)
> +      Needed for make check and tests.
> +
>      - SWIG >= 2.0 (optional)
>        Needed for Python bindings (--enable-python-bindings).
>  
