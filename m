From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH] Provide tcsh completion
Date: Fri, 24 Apr 2015 11:48:16 -0400
Message-ID: <CAFXXi0kv42=bFVRNFq8_K1WCsWxus0JHNSEaznzvedUiPp6ZUA__41789.3302081667$1429890613$gmane$org@mail.gmail.com>
References: <CAFj1UpFdHezePu=682pSsdrnfAZtmgZSnd4jPinCZUS1WH-8cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1YlfqW-0006ys-C0
 for lttng-dev@lists.lttng.org; Fri, 24 Apr 2015 11:49:00 -0400
Received: by igbyr2 with SMTP id yr2so18272098igb.0
 for <lttng-dev@lists.lttng.org>; Fri, 24 Apr 2015 08:48:46 -0700 (PDT)
In-Reply-To: <CAFj1UpFdHezePu=682pSsdrnfAZtmgZSnd4jPinCZUS1WH-8cg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Marc Khouzam <marc.khouzam@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 24 April 2015 at 10:14, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> The new script 'lttng-tcsh_completion' is provided to allow
> command-completion for the tcsh shell.
>
> The approach taken by this script is to to re-use the advanced bash
> completion script and use its result for tcsh completion.  This is
> achieved by running the bash script and outputting the completion
> result for tcsh consumption.
>
> This approach is based on a similar script used in the git project.
>
> To use this completion script:
>
>    0) You need tcsh 6.16.00 or newer.
>    1) Copy both this file and the bash completion script to ${HOME}.
>       You _must_ use the name ${HOME}/.lttng-bash_completion for the
>       bash script.
>       (e.g. ~/.lttng-tcsh_completion and ~/.lttng-bash_completion).
>    2) Add the following line to your .tcshrc/.cshrc:
>        source ~/.lttng-tcsh_completion
>    3) For completion similar to bash, it is recommended to also
>       add the following line to your .tcshrc/.cshrc:
>        set autolist=ambiguous
>       It will tell tcsh to list the possible completion choices.
>
> Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
> ---
>  extras/lttng-tcsh_completion |  163 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100755 extras/lttng-tcsh_completion
>
> diff --git a/extras/lttng-tcsh_completion b/extras/lttng-tcsh_completion
> new file mode 100755
> index 0000000..1ce677a
> --- /dev/null
> +++ b/extras/lttng-tcsh_completion
> @@ -0,0 +1,163 @@
> +#!tcsh
> +#
> +# tcsh completion support for core lttng.
> +#
> +# Copyright (C) 2015 Marc Khouzam <marc.khouzam@gmail.com>
> +# Distributed under the GNU General Public License, version 2.0.
> +#
> +# When sourced, this script will generate a new script that uses
> +# the lttng-bash_completion script provided by core lttng.  This new
> +# script can be used by tcsh to perform lttng completion.
> +# The current script also issues the necessary tcsh 'complete'
> +# commands.
> +#
> +# To use this completion script:
> +#
> +#    0) You need tcsh 6.16.00 or newer.
> +#    1) Copy both this file and the bash completion script to ${HOME}.
> +#       You _must_ use the name ${HOME}/.lttng-bash_completion for the
> +#       bash script.
> +#       (e.g. ~/.lttng-tcsh_completion and ~/.lttng-bash_completion).
> +#    2) Add the following line to your .tcshrc/.cshrc:
> +#        source ~/.lttng-tcsh_completion
> +#    3) For completion similar to bash, it is recommended to also
> +#       add the following line to your .tcshrc/.cshrc:
> +#        set autolist=ambiguous
> +#       It will tell tcsh to list the possible completion choices.
> +#
> +# To debug this script one can use the -d flag by running the
> +# generated final script directly.  For example, to see the completions
> +# generated when pressing <tab> for the command line:
> +#     lttng s
> +# one should run:
> +#     bash ~/.lttng-tcsh_completion.bash -d lttng 'lttng s
> +# and will obtain:
> +#     =====================================
> +#     lttng-bash_completion returned:
> +#     start stop set-session snapshot save
> +#     =====================================
> +#     Completions including tcsh additions:
> +#     start stop set-session snapshot save
> +#     =====================================
> +#     Final completions returned:
> +#     save
> +#     set-session
> +#     snapshot
> +#     start
> +#     stop
> +#
> +
> +set __lttng_tcsh_completion_version = `\echo ${tcsh} | \sed 's/\./ /g'`
> +if ( ${__lttng_tcsh_completion_version[1]} < 6 || \
> +     ( ${__lttng_tcsh_completion_version[1]} == 6 && \
> +       ${__lttng_tcsh_completion_version[2]} < 16 ) ) then
> +       echo "lttng-tcsh_completion: Your version of tcsh is too old,
> you need version 6.16.00 or newer.  lttng completion will not work."
> +       exit
> +endif
> +unset __lttng_tcsh_completion_version
> +
> +set __lttng_tcsh_completion_original_script = ${HOME}/.lttng-bash_completion
> +set __lttng_tcsh_completion_script = ${HOME}/.lttng-tcsh_completion.bash
> +
> +# Check that the user put the script in the right place
> +if ( ! -e ${__lttng_tcsh_completion_original_script} ) then
> +       echo "lttng-completion.tcsh: Cannot find:
> ${__lttng_tcsh_completion_original_script}.  lttng completion will not
> work."
> +       exit
> +endif
> +
> +cat << EOF > ${__lttng_tcsh_completion_script}
> +#!bash
> +#
> +# This script is GENERATED and will be overwritten automatically.
> +# Do not modify it directly.  Instead, modify lttng-tcsh_completion
> +# and source it again.
> +
> +# Allow for debug printouts when running the script by hand
> +if [ "\$1" == "-d" ] || [ "\$1" == "--debug" ]; then
> +       __lttng_tcsh_debug=true
> +       shift
> +fi
> +
> +source /etc/bash_completion
> +source ${__lttng_tcsh_completion_original_script}
> +
> +# Remove the colon as a completion separator because tcsh cannot handle it
> +COMP_WORDBREAKS=\${COMP_WORDBREAKS//:}
> +
> +# Set COMP_WORDS in a way that can be handled by the bash script.
> +COMP_WORDS=(\$1 \$2)
> +COMP_LINE="\$1 \$2"
> +COMP_POINT=\${#COMP_LINE}
> +
> +# The cursor is at the end of parameter #1.
> +# We must check for a space as the last character which will
> +# tell us that the previous word is complete and the cursor
> +# is on the next word.
> +if [ "\${2: -1}" == " " ]; then
> +       # The last character is a space, so our location is at the end
> +       # of the command-line array
> +       COMP_CWORD=\${#COMP_WORDS[@]}
> +else
> +       # The last character is not a space, so our location is on the
> +       # last word of the command-line array, so we must decrement the
> +       # count by 1
> +       COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
> +fi
> +
> +# Call _lttng() of the bash script, based on the first argument
> +_\${1}
> +
> +if [ "\$__lttng_tcsh_debug" == "true" ]; then
> +       echo =====================================
> +       echo lttng-bash_completion returned:
> +       echo "\${COMPREPLY[@]}"
> +fi
> +
> +IFS=\$'\n'
> +if [ \${#COMPREPLY[*]} -eq 0 ]; then
> +       # No completions suggested.  In this case, we want tcsh to perform
> +       # standard file completion.  However, there does not seem to be way
> +       # to tell tcsh to do that.  To help the user, we try to simulate
> +       # file completion directly in this script.
> +       #
> +       # Known issues:
> +       #     - Possible completions are shown with their directory prefix.
> +       #     - Completions containing shell variables are not handled.
> +       #     - Completions with ~ as the first character are not handled.
> +
> +       # No file completion should be done unless we are completing beyond
> +       # the lttng sub-command.  An improvement on the bash completion :)
> +       if [ \${COMP_CWORD} -gt 1 ]; then
> +               TO_COMPLETE="\${COMP_WORDS[\${COMP_CWORD}]}"
> +
> +               # We don't support ~ expansion: too tricky.
> +               if [ "\${TO_COMPLETE:0:1}" != "~" ]; then
> +                       # Use ls so as to add the '/' at the end of directories.
> +                       COMPREPLY=(\`ls -dp \${TO_COMPLETE}* 2> /dev/null\`)
> +               fi
> +       fi
> +fi
> +
> +if [ "\$__lttng_tcsh_debug" == "true" ]; then
> +       echo =====================================
> +       echo Completions including tcsh additions:
> +       echo "\${COMPREPLY[@]}"
> +       echo =====================================
> +       echo Final completions returned:
> +fi
> +
> +# tcsh does not automatically remove duplicates, so we do it ourselves
> +echo "\${COMPREPLY[*]}" | sort | uniq
> +
> +# If there is a single completion and it is a directory, we output it
> +# a second time to trick tcsh into not adding a space after it.
> +if [ \${#COMPREPLY[*]} -eq 1 ] && [ "\${COMPREPLY[0]: -1}" == "/" ]; then
> +       echo "\${COMPREPLY[*]}"
> +fi
> +
> +EOF
> +
> +# Don't need this variable anymore, so don't pollute the users environment
> +unset __lttng_tcsh_completion_original_script
> +
> +complete lttng  'p,*,`bash ${__lttng_tcsh_completion_script} lttng
> "${COMMAND_LINE}"`,'
> --
> 1.7.9.5
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

I haven't checked it in details (there is too much black magic
happening for me), but I tested it and it seems to work well.

There are a few lines in your patch that are wrapped (I guess because
you used gmail to send it), so it doesn't apply cleanly. Next time,
you could try using git send-email, for example:

$ git send-email \
    --to lttng-dev@lists.lttng.org \
    --smtp-server smtp.electronicbox.net \
    --annotate HEAD^

Obviously, change or omit the --smtp-server according to your setup/ISP.

Thanks!

Simon
