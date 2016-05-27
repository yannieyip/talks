.PHONY: slides watch-slides

slides:
	grep -vh '^#' slides/*.replesent | grep -vh '^//-.*$$' | sed 's~^//+~~' > REPLesent.txt

predef:
	echo '' > src/main/scala/Predef.scala
	echo 'import ReplDefinitions._' >> src/main/scala/Predef.scala
	echo 'trait Predef { self: ApplicativeExt =>' >> src/main/scala/Predef.scala
	grep -vh '^#' slides/*.replesent | sed -n -e '/^```/,/^```/ p' | sed 's/^```$$//' >> src/main/scala/Predef.scala
	echo '}' >> src/main/scala/Predef.scala
	echo 'object Predef extends Predef with ApplicativeExt' >> src/main/scala/Predef.scala

watch-slides:
	while true; do \
		ls slides/* | entr -d \
			make slides; \
		sleep 1; \
	done;
