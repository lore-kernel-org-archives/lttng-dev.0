From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [PATCH] lttng-gen-tp: remove support for # comments
Date: Tue, 18 Jun 2013 15:38:23 -0400
Message-ID: <51C0B72F.2080404__33739.0418084853$1371584360$gmane$org@gmail.com>
References: <1371577764-7740-1-git-send-email-romain.lenglet@berabera.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Up1jf-0007Ki-VG
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 15:38:36 -0400
Received: by mail-ve0-f170.google.com with SMTP id 14so3480093vea.1
	for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2013 12:38:30 -0700 (PDT)
In-Reply-To: <1371577764-7740-1-git-send-email-romain.lenglet@berabera.info>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Romain Lenglet <romain.lenglet@berabera.info>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-06-18 13:49, Romain Lenglet wrote:
> Support #define, #include, etc. in tracepoint files.
Do you have a specific use case that demonstrate the need for that?

The design goal of lttng-gen-tp included generating tracepoints for
other language than C, so we wanted a format more agnostics hence the
support for # comments

> Signed-off-by: Romain Lenglet <romain.lenglet@berabera.info>
> ---
>  doc/man/lttng-gen-tp.1 |    2 +-
>  tools/lttng-gen-tp     |    3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/doc/man/lttng-gen-tp.1 b/doc/man/lttng-gen-tp.1
> index 84c05c9..96f02c4 100644
> --- a/doc/man/lttng-gen-tp.1
> +++ b/doc/man/lttng-gen-tp.1
> @@ -64,7 +64,7 @@ TRACEPOINT_LOGLEVEL.
>  (See lttng-ust(3) for the complete list of available definition.)
>  
>  You write them as you would write them in a C header file. You can add
> -comments with \fB/* */\fP, \fB//\fP and \fB#\fP.
> +comments with \fB/* */\fP and \fB//\fP.
>  
>  The provider name (the first field of TRACEPOINT_EVENT) must be
>  the same for the whole file.
> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> index 5937dfd..5ea221b 100755
> --- a/tools/lttng-gen-tp
> +++ b/tools/lttng-gen-tp
> @@ -159,9 +159,6 @@ class TemplateFile:
>  
>          self.text = f.read()
>  
> -        #Remove # comments (from input and output file
> -        removeComments = re.compile("#.*$",flags=re.MULTILINE)
> -        self.text = removeComments.sub("",self.text)
>          #Remove // comments
>          removeLineComment = re.compile("\/\/.*$",flags=re.MULTILINE)
>          nolinecomment = removeLineComment.sub("",self.text)
