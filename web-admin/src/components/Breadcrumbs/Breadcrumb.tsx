import Link from "next/link";

interface BreadcrumbProps {
  pageName: string;
  parentPages?: { name: string; href: string }[];
}

const Breadcrumb = ({ pageName, parentPages = [] }: BreadcrumbProps) => {
  return (
    <div className="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
      <h2 className="text-[26px] font-bold leading-[30px] text-dark dark:text-white">
        {pageName}
      </h2>

      <nav>
        <ol className="flex items-center gap-2 text-sm">
          <li>
            <Link className="font-medium text-gray-600 dark:text-gray-300" href="/">
              Dashboard /
            </Link>
          </li>
          {parentPages.map((parent, index) => (
            <li key={index}>
              <Link className="font-medium text-gray-600 dark:text-gray-300" href={parent.href}>
                {parent.name} /
              </Link>
            </li>
          ))}
          <li className="font-medium text-primary">{pageName}</li>
        </ol>
      </nav>
    </div>
  );
};

export default Breadcrumb;
