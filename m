From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng-UST PATCH] Allow #include in template (.tp)
	file
Date: Sat, 22 Jun 2013 13:50:09 -0400
Message-ID: <20130622175009.GA26219__7578.38307549736$1371923444$gmane$org@Krystal>
References: <1371921972-4294-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UqRwy-0000hI-LM
	for lttng-dev@lists.lttng.org; Sat, 22 Jun 2013 13:50:12 -0400
Content-Disposition: inline
In-Reply-To: <1371921972-4294-1-git-send-email-yannick.brosseau@gmail.com>
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

merged into master and stable-2.2.

Thanks,

Mathieu

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> The #include directive won't be parsed, but will be copied to the
> generated .h files.
> 
> Also add a verbose (-v) mode to display some debugging output
> 
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  tools/lttng-gen-tp |   19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> index 5937dfd..1ff9146 100755
> --- a/tools/lttng-gen-tp
> +++ b/tools/lttng-gen-tp
> @@ -145,6 +145,8 @@ class ObjFile:
>              cflags = ""
>  
>          command = cc + " -c " + cflags + " -I. -llttng-ust" + " -o " + self.outputFilename + " " + cFilename
> +        if verbose:
> +            print("Compile command: " + command)
>          subprocess.call(command.split())
>  
>  class TemplateFile:
> @@ -159,12 +161,16 @@ class TemplateFile:
>  
>          self.text = f.read()
>  
> -        #Remove # comments (from input and output file
> -        removeComments = re.compile("#.*$",flags=re.MULTILINE)
> +        #Remove # comments (from input and output file) but keep 
> +        # #include in the output file
> +        removeComments = re.compile("#[^include].*$",flags=re.MULTILINE)
>          self.text = removeComments.sub("",self.text)
> +        # Remove #include directive from the parsed text
> +        removePreprocess = re.compile("#.*$",flags=re.MULTILINE)
> +        noPreprocess = removePreprocess.sub("", self.text)
>          #Remove // comments
>          removeLineComment = re.compile("\/\/.*$",flags=re.MULTILINE)
> -        nolinecomment = removeLineComment.sub("",self.text)
> +        nolinecomment = removeLineComment.sub("", noPreprocess)
>          #Remove all spaces and lines
>          cleantext = re.sub("\s*","",nolinecomment)
>          #Remove multine C style comments
> @@ -184,6 +190,8 @@ class TemplateFile:
>                      if self.domain != domain:
>                          print "Warning: different domain provided (%s,%s)" % (self.domain, domain)
>  
> +verbose=False
> +
>  usage="""
>   lttng-gen-tp - Generate the LTTng-UST header and source based on a simple template
>  
> @@ -206,7 +214,7 @@ def main(argv=None):
>  
>      try:
>          try:
> -            opts, args = getopt.gnu_getopt(argv[1:], "ho:a", ["help"])
> +            opts, args = getopt.gnu_getopt(argv[1:], "ho:av", ["help","verbose"])
>          except getopt.error, msg:
>               raise Usage(msg)
>  
> @@ -224,6 +232,9 @@ def main(argv=None):
>              outputNames.append(a)
>          if o in ("-a",""):
>              all = True
> +        if o in ("-v", "--verbose"):
> +            global verbose
> +            verbose = True
>      try:
>          if len(args) == 0:
>              raise Usage("No template file given")
> -- 
> 1.7.10.4
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
