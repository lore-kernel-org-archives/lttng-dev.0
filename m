From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Add missing
 test_utils_parse_size_suffix to unit tests
Date: Mon, 06 May 2013 11:36:47 -0400
Message-ID: <5187CE0F.3020202__32191.9264192276$1367854650$gmane$org@efficios.com>
References: <1367854327-17078-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UZNTD-0007Ao-Ok
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 11:36:55 -0400
In-Reply-To: <1367854327-17078-1-git-send-email-christian.babeux@efficios.com>
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

Merged

Christian Babeux:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/unit_tests | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/unit_tests b/tests/unit_tests
> index d7c68b6..6bf33cc 100644
> --- a/tests/unit_tests
> +++ b/tests/unit_tests
> @@ -2,3 +2,4 @@ unit/test_kernel_data
>  unit/test_session
>  unit/test_uri
>  unit/test_ust_data
> +unit/test_utils_parse_size_suffix
