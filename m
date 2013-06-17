From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng-UST PATCH] lttng-gen-tp: Fix include guard
	name with	file using non valid characters
Date: Mon, 17 Jun 2013 12:11:25 -0400
Message-ID: <20130617161125.GA7818__32734.2725046494$1371485518$gmane$org@Krystal>
References: <1371484991-8578-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uoc1e-0002Dm-BY
	for lttng-dev@lists.lttng.org; Mon, 17 Jun 2013 12:11:26 -0400
Content-Disposition: inline
In-Reply-To: <1371484991-8578-1-git-send-email-yannick.brosseau@gmail.com>
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

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> Now, the include guard will be generated with all the non
> alpha-numeric characters replace with an '_'

merged in:
- master
- stable 2.2, 2.1, 2.0.

I also merged that commit into stable-2.0 so the current commit applies:

commit f1d29bdce822f8432965b2db23d46ef79d2691a9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Dec 13 15:05:26 2012 -0500

    Cleanup lttng-gen-tp: remove leading underscore before include guard
    
    Fixes #298
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> Fixes #511
> 
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  tools/lttng-gen-tp |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> index 2f468cb..5937dfd 100755
> --- a/tools/lttng-gen-tp
> +++ b/tools/lttng-gen-tp
> @@ -61,7 +61,9 @@ extern "C"{{
>  
>      def write(self):
>          outputFile = open(self.outputFilename,"w")
> -        includeGuard = self.outputFilename.upper().replace(".","_")
> +        # Include guard macro will be created by uppercasing the filename and
> +        # replacing all non alphanumeric characters with '_'
> +        includeGuard = re.sub('[^0-9a-zA-Z]', '_', self.outputFilename.upper())
>  
>          outputFile.write(HeaderFile.HEADER_TPL.format(providerName=self.template.domain,
>                                             includeGuard = includeGuard,
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
