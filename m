From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] lttng-gen-tp: Allow generation
	from	templates in subdirectories
Date: Mon, 3 Sep 2012 13:53:37 -0400
Message-ID: <20120903175337.GD13776__24069.1324034289$1346694854$gmane$org@Krystal>
References: <1346272799-23183-1-git-send-email-sbohrer@rgmadvisors.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T8aqA-0007N0-Lq
	for lttng-dev@lists.lttng.org; Mon, 03 Sep 2012 13:53:38 -0400
Content-Disposition: inline
In-Reply-To: <1346272799-23183-1-git-send-email-sbohrer@rgmadvisors.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shawn Bohrer <sbohrer@rgmadvisors.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Shawn Bohrer (sbohrer@rgmadvisors.com) wrote:
> If a template is located in a subdirectory as is common in large
> software projects then the include guard will contain forward slash
> characters which are not allowed.  This replaces those characters with
> an underscore.  Additional the include guards previously started with
> an underscore and capital letter which is reserved thus this
> additionally removes the leading underscore.

[for lttng-tools]

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Fixes: #298
> 
> Signed-off-by: Shawn Bohrer <sbohrer@rgmadvisors.com>
> ---
>  tools/lttng-gen-tp |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> index d54559a..8cd3191 100755
> --- a/tools/lttng-gen-tp
> +++ b/tools/lttng-gen-tp
> @@ -61,7 +61,7 @@ extern "C"{{
>  
>      def write(self):
>          outputFile = open(self.outputFilename,"w")
> -        includeGuard = "_"+self.outputFilename.upper().replace(".","_")
> +        includeGuard = self.outputFilename.upper().replace(".","_").replace("/","_")
>  
>          outputFile.write(HeaderFile.HEADER_TPL.format(providerName=self.template.domain,
>                                             includeGuard = includeGuard,
> -- 
> 1.7.7.6
> 
> 
> -- 
> 
> ---------------------------------------------------------------
> This email, along with any attachments, is confidential. If you 
> believe you received this message in error, please contact the 
> sender immediately and delete all copies of the message.  
> Thank you.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
